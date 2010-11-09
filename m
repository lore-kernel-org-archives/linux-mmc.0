From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2.6.35]: Add new device IDs and registers for
	MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Tue, 9 Nov 2010 15:38:06 +0000
Message-ID: <20101109153806.GC7977@void.printf.net>
References: <FC57104DF444434A9D1D8A7B4EBB292307BD1F6D@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55239 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab0KIPiI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 10:38:08 -0500
Content-Disposition: inline
In-Reply-To: <FC57104DF444434A9D1D8A7B4EBB292307BD1F6D@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Cc: linux-mmc@vger.kernel.org, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, Rezwanul_Kabir@Dell.com, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>

Hi Jennifer,

On Tue, Nov 09, 2010 at 02:28:00PM +0800, Jennifer Li (TP) wrote:
> Hi,
>=20
> This can make MMC/SD driver work on O2 chip.
>=20
> Best regards,
> Jennifer

Thanks for the patch submission.  There are some changes that need to
be made before this can be accepted into the kernel -- you can read
more about the patch guidelines here:

http://www.kernel.org/doc/Documentation/SubmittingPatches
http://www.kernel.org/doc/Documentation/CodingStyle

In particular:

* The patch needs a "Signed-off-by" line.

* Please submit a summary that explains how the patch works in general.
  Your directory name mentions "SD_ADMAissue_8220_8320" -- could you
  explain what that issue is, and how this patch fixes it?  I guess
  I'm particularly interested in why you have to make so many PCI
  config writes, and what they achieve.

* It would be ideal if you could generate the patch using Git, and if i=
t
  could be based on 2.6.36 or newer instead of 2.6.35.

* In lines like this:
         ret =3D pci_read_config_byte(chip->pdev, 0xD3, &scratch);
  please use symbolic names -- the name of the register -- instead
  of numbers like 0xD3.  For example, from via-sdmmc.c:

	#define VIA_CRDR_PCI_WORK_MODE  0x40
	#define VIA_CRDR_PCI_DBG_MODE   0x41
	...
	pci_write_config_byte(pcidev, VIA_CRDR_PCI_WORK_MODE, 0);
	pci_write_config_byte(pcidev, VIA_CRDR_PCI_DBG_MODE, 0);

* Instead of comments like "// set E0 to 0x73", please describe what's
  actually happening to the hardware.  For example, from the jmicron
  code:
        /*
         * Turn PMOS on [bit 0], set over current detection to 2.4 V
         * [bit 1:2] and enable over current debouncing [bit 6].
         */

  (Linux uses "/* */" comments rather than "//" comments.)

* Commented-out code shouldn't be submitted:

+// .quirks=A0=A0=A0=A0 =3D SDHCI_QUICK_ADMA_TABLE_ENTRY,

* The PCI device ID symbols should only be added to include/linux/pci_i=
ds.h.
  There's already a space for other O2 devices in there.

* I think it's generally okay not to check the return value on
  pci_write_config_byte().

Please fix these and resubmit the patch.  Thanks!

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
