From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: What should the SDHCI regulator control?
Date: Fri, 24 Feb 2012 14:49:43 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCDEE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Chris,

A question about regulators for SD cards:

We have a few boards, with some slightly different setups:

Setup 1: (Harmony, Seaboard, Ventana, AC100)

Power to SD is fixed at 3.3V

There is a GPIO to enable power, which gates the SD connector's VDD pin
and the pullups on DAT/CMD lines.

Setup 2 (Cardhu):

There is a regulator in a PMU/PMIC which can supply a variable voltage,
which is fed to the SoC's SD controller (presumably affects the IO pad
voltage), and the pullups on the DAT/CMD lines.

There is a fixed 3.3V supply, with a GPIO to enable/disable it, which
is fed only to the SD connector's VDD pin.

Question 1: In case 2,

Is the card always supposed to receive 3.3V here; is an SD card supposed
to contain its own internal regulator to generate e.g. a 1.85V IO voltage
rather than being supplied with the lower voltage?

Question 2: In general,

So, there's always a GPIO to gate power to the SD connector, but any
variable voltage is not fed the the SD card itself, only the SoC. Also,
the GPIO sometimes affects the CMD/DAT pullups, whereas sometimes they're
affected by the variable regulator.

Is the regulator returned by the regulator_get() call in sdhci_add_host()
supposed to control the GPIO (or should the GPIO always be switched on?)
or should it control the variable regulator that affects only the SoC,
or both at once, or ...?

Thanks.

-- 
nvpublic
