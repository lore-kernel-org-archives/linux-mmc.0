From: Naveen Kumar Parna <pnaveenkos@gmail.com>
Subject: PCIe: Xilinx: sdhci-pci: probe() issue
Date: Mon, 20 Jul 2015 16:25:10 +0530
Message-ID: <CAG0bkv+Sve7+XWtGk-kkQU=-64CPbpE=5RMbVq-RzWNgg--6ZQ__40530.7408924729$1437389723$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33744 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbGTKzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 06:55:11 -0400
Received: by igbqa2 with SMTP id qa2so7239381igb.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2015 03:55:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-pci@vger.kernel.org

Hi ,

I have a Verilog image & hardware which provides a PCIe interface with
two BAR=E2=80=99s(BAR0 & BAR1) to host.

BAR0 is having customized UART, GPIO and 1-wire prom modules. These
modules are accessed via customized PCIe interface driver.

BAR1 is having SD Host controller as per SD Specifications. Here
requirement is such that we should use Linux kernel stack drivers
(sdhci.ko & sdhci-pci.ko).


Here the issue is only one driver=E2=80=99s probe() function gets execu=
ted
i.e. either customized PCIe driver or sdhci-pci.ko.


Output of lspci:
02:00.0 SD Host controller: PLDA Device 5555


Customized PCIe driver's struct pci_device_id:
static struct pci_device_id pci_id_table[] =3D {

    { PCI_DEVICE( 0x1556, 0x5555)},

    { 0 },

};


=46or example: If I load the customized PCIe driver first and then
sdhci-pci, then only customized PCIe driver=E2=80=99s probe() function =
gets
called.

If I change the order of loading the module i.e. sdhci-pci first then
only sdhci-pci=E2=80=99s probe gets called.


Is there any better solution to use customized PCIe driver for BAR0
and sdhci for BAR1?

I will be happy to provide additional debugging info, just let me know.


Thanks,
Naveen
