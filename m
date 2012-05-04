From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
Date: Fri, 04 May 2012 10:08:49 -0400
Message-ID: <87fwbgt4we.fsf@laptop.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
	<1334325909-5779-7-git-send-email-lee.jones@linaro.org>
	<CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
	<4F8BE5B0.4000900@linaro.org>
	<20120425185747.GC24211@n2100.arm.linux.org.uk>
	<4FA29E46.6040204@linaro.org>
	<20120503151253.GE897@n2100.arm.linux.org.uk>
	<4FA2A4A8.9010208@linaro.org>
	<20120503163008.GF897@n2100.arm.linux.org.uk>
	<4FA2B4A3.2040402@linaro.org>
	<20120503164501.GG897@n2100.arm.linux.org.uk>
	<8762cdur7o.fsf@laptop.org> <4FA3D720.7010004@linaro.org>
	<87mx5ot6vp.fsf@laptop.org> <4FA3DEEF.2010206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40685 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634Ab2EDOIs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 May 2012 10:08:48 -0400
In-Reply-To: <4FA3DEEF.2010206@linaro.org> (Lee Jones's message of "Fri, 04
	May 2012 14:51:43 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi Lee,

On Fri, May 04 2012, Lee Jones wrote:
> The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:
>
>   Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/ljones/linux-3.0-ux500.git mmc-for-chrisb
>
> for you to fetch changes up to b6e0fdd89668db08a40f8cbe687b23f1eaf15b5a:
>
>   drivers/mmc: MMCI: Use correct GPIO binding for IRQ requests
> (2012-05-04 14:47:28 +0100)
>
> ----------------------------------------------------------------
> Lee Jones (3):
>       MMC: mmci: Enable Device Tree support for ux500 variants
>       MMC: mmci: Add required documentation for Device Tree bindings
>       drivers/mmc: MMCI: Use correct GPIO binding for IRQ requests
>
>  Documentation/devicetree/bindings/mmc/mmci.txt |   19 ++++++++
>  drivers/mmc/host/mmci.c                        |   59
> ++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

Thanks very much, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
