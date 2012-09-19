From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: Enable only required bus clock
Date: Wed, 19 Sep 2012 02:12:15 -0400
Message-ID: <m3obl2ils0.fsf@pullcord.laptop.org>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
	<1347613731-29428-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1347613731-29428-2-git-send-email-chander.kashyap@linaro.org>
	(Chander Kashyap's message of "Fri, 14 Sep 2012 14:38:49 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Sep 14 2012, Chander Kashyap wrote:
> In case of multiple bus clock sources, all the clock sources were
> getting enabled. As only one clock source is needed at the time hence
> enable only the required bus clock.
>
> This patch does as follows:
> 1.	In sdhci_s3c_probe enable only required bus clock source.
>
> 2.	Handle the disabling of old bus clock and enables the
> 	best clock selected in sdhci_s3c_set_clock().
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
