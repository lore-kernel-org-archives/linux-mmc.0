From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix regression: restore TMIO_MMC_WRPROTECT_DISABLE handling
Date: Mon, 20 Jun 2011 15:25:09 -0400
Message-ID: <m239j4z4oa.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1106201648480.11365@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1106201648480.11365@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 20 Jun 2011 16:51:10 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 20 2011, Guennadi Liakhovetski wrote:
> Commit b6147490e6aac82fa2f4b9d7fce925d9891ebe8f broke handling of the
> TMIO_MMC_WRPROTECT_DISABLE flag by the tmio-mmc driver. This patch
> restores the original behaviour.

Changed to:

Commit b6147490e6aac82 ("mmc: tmio: split core functionality, DMA and
MFD glue") broke handling of the TMIO_MMC_WRPROTECT_DISABLE flag by 
the tmio-mmc driver. This patch restores the original behaviour.

Please use patch names as well as commit IDs for references.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Chris, please push for 3.0

And stable@, presumably, since the patch was in 2.6.39?

Pushed to mmc-next for 3.0 and stable.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
