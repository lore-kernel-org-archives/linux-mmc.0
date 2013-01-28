From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: fix host version read
Date: Mon, 28 Jan 2013 16:27:29 -0500
Message-ID: <877gmx80ce.fsf@laptop.org>
References: <1358263827-3379-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1358263827-3379-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Tue, 15 Jan 2013 23:30:27 +0800")
Sender: stable-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Tue, Jan 15 2013, Shawn Guo wrote:
> When commit 95a2482 (mmc: sdhci-esdhc-imx: add basic imx6q usdhc
> support) works around host version issue on imx6q, it gets the
> register address fixup "reg ^= 2" lost for imx25/35/51/53 esdhc.
> Thus, the controller version on these SoCs is wrongly identified
> as v1 while it's actually v2.
>
> Add the address fixup back and take a different approach to correct
> imx6q host version, so that the host version read gets back to work
> for all SoCs.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: <stable@vger.kernel.org>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
