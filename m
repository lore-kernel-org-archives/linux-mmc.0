From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: linux-2.6.36-rc4 problems booting rootfs from SD card
Date: Tue, 28 Sep 2010 20:08:48 +0100
Message-ID: <20100928190848.GA8649@n2100.arm.linux.org.uk>
References: <20100928130043.000074b1@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46469 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0I1TJ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 15:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20100928130043.000074b1@unknown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dylan cristiani <d.cristiani@idem-tech.it>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Sep 28, 2010 at 01:00:43PM +0200, dylan cristiani wrote:
> Hi sirs, here is my scenario: kernel 2.6.36-rc4; cpu pxa270; platform
> is an enhancement (i like to see things that way...) and customisation
> of the mainstone III board; here comes the (my) problem: if i boot with
> my standard kernel boot command line (to boot from system flash):
> 'root=/dev/mtdblock2 rootfstype=jffs2 mem=64M console=ttyS0,115200n8'
> 
> i can get the rootfs up, and the SD card is up too, and correctly
> working; here's the relevant kernel log:

Use 'rootdelay=1' to give time for the SD card to be detected.
