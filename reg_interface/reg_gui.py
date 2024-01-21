import tkinter as tk
from tkinter import ttk
import tkinter.filedialog as filedialog

class RegisterGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Register Entry GUI")

        self.scroll_frame = ttk.Frame(self.root)
        self.scroll_frame.pack(side=tk.LEFT, fill=tk.Y)

        self.canvas = tk.Canvas(self.scroll_frame, width=200)
        self.scrollbar = ttk.Scrollbar(self.scroll_frame, orient="vertical", command=self.canvas.yview)
        self.scrollable_frame = ttk.Frame(self.canvas)

        self.scrollable_frame.bind(
            "<Configure>",
            lambda e: self.canvas.configure(
                scrollregion=self.canvas.bbox("all")
            )
        )

        self.canvas.create_window((0, 0), window=self.scrollable_frame, anchor="nw")
        self.canvas.configure(yscrollcommand=self.scrollbar.set)

        self.canvas.pack(side="left", fill="both", expand=True)
        self.scrollbar.pack(side="right", fill="y")

        self.entries = []
        for i in range(32):
            label = ttk.Label(self.scrollable_frame, text=f"x{i}:")
            entry = ttk.Entry(self.scrollable_frame)
            label.grid(row=i, column=0, padx=5, pady=5, sticky="e")
            entry.grid(row=i, column=1, padx=5, pady=5)
            self.entries.append(entry)

        save_button = ttk.Button(self.root, text="Save to Hex File", command=self.save_to_hex)
        save_button.pack(pady=10)

    def save_to_hex(self):
        print("Save button clicked")  # Debugging statement

        hex_values = ["@00000000"]  # Starting address
        for i, entry in enumerate(self.entries):
            value = entry.get().strip()

            if not value:
                value = "0"  # Set default value to 0 if entry is blank

            try:
                decimal_value = int(value)
                hex_value = format(decimal_value, '08X')
            except ValueError:
                print(f"Invalid value: {value} is not a valid decimal integer")
                continue

            hex_values.append(hex_value)

        file_path = filedialog.asksaveasfilename(defaultextension=".hex", filetypes=[("Hex Files", "*.hex")])

        if file_path:
            try:
                with open(file_path, "w") as hex_file:
                    hex_file.write("\n".join(hex_values) + '\n')  # Ensure a newline at the end
                print(f"Saved to {file_path}")
            except Exception as e:
                print(f"Error writing to file: {e}")

if __name__ == "__main__":
    root = tk.Tk()
    gui = RegisterGUI(root)
    root.mainloop()
