From: Harald Dunkel <harri@afaics.de>
Subject: Re: [Bugme-new] [Bug 32242] New: irq 18, nobody cared, nor did irqpoll
Date: Thu, 31 Mar 2011 12:59:12 +0200
Message-ID: <4D945E80.8080104@afaics.de>
References: <bug-32242-10286@https.bugzilla.kernel.org/>
	<20110330165140.c5ca5705.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20110330165140.c5ca5705.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, bugzilla-daemon@bugzilla.kernel.org, linux-mmc@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/31/11 01:51, Andrew Morton wrote:
> 
> So both sdhci_irq and r852_irq were looking at the IRQ, but neither of
> them were interested in it.
> 
> Could be that the bug lies in neither driver, at that something went
> wrong with the system setup.  ACPI?
> 

Currently I cannot reproduce it, with or without acpi. /var/log/messages
shows this morning:

[    1.004550] sdhci: Secure Digital Host Controller Interface driver
[    1.004552] sdhci: Copyright(c) Pierre Ossman
[    1.005643] sdhci-pci 0000:03:01.1: SDHCI controller found [1180:0822] (rev 22)
[    1.005662] sdhci-pci 0000:03:01.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[    1.007252] tg3.c:v3.116 (December 3, 2010)
[    1.007268] tg3 0000:09:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.007513] usbcore: registered new interface driver usbfs
[    1.007537] usbcore: registered new interface driver hub
[    1.010765] mmc0: SDHCI controller on PCI [0000:03:01.1] using DMA
[    1.010775] sdhci-pci 0000:03:01.2: SDHCI controller found [1180:0843] (rev 12)
[    1.010786] sdhci-pci 0000:03:01.2: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[    1.013877] mmc1: SDHCI controller on PCI [0000:03:01.2] using DMA
:
:
[    8.216702] r852 0000:03:01.4: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[    8.243648] r852: driver loaded succesfully


:-{

When it comes back I will try to reboot with acpi=off.


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk2UXoAACgkQUTlbRTxpHjcragCghaLRrZJn7pkhbpkzfK0KjstI
Sw8AniBuFLr0kIpE6ImtJ0b4hdQlILzW
=ukS3
-----END PGP SIGNATURE-----

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
