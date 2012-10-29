From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 29 Oct 2012 17:10:37 -0400
Message-ID: <87txtdq90y.fsf@octavius.laptop.org>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
	<20121015103725.GQ21164@n2100.arm.linux.org.uk>
	<20121015104456.GR21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36491 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760973Ab2J2VKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 17:10:43 -0400
In-Reply-To: <20121015104456.GR21164@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 15 Oct 2012 11:44:56 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Mon, Oct 15 2012, Russell King - ARM Linux wrote:
> Here's an updated patch which just about fixes the sdhci-dove driver.
> I would not be surprised given the idiotic sdhci-pltfm API if many
> other drivers suffered the same bug.
>
> 8<=3D=3D=3D=3D
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] MMC: fix sdhci-dove probe/removal
>
> 1. Never ever publish a device in the system before it has been setup
>    to a usable state.
> 2. Unregister the device _BEFORE_ taking away any resources it may be
>    using.
> 3. Don't check clks against NULL.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This version of the patch doesn't apply cleanly or compile -- maybe you
have a later revision?

/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c: In function =E2=80=98s=
dhci_dove_probe=E2=80=99:
/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c:109:2: error: implicit =
declaration of function =E2=80=98clk_unprepare_disable=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c:111:1: warning: label =E2=
=80=98sdhci_dove_allocate_fail=E2=80=99 defined but not used [-Wunused-=
label]

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
