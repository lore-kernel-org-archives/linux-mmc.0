From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Add device tree support
Date: Thu, 16 Aug 2012 11:47:03 -0400
Message-ID: <87obmadeko.fsf@octavius.laptop.org>
References: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1345132169-21066-1-git-send-email-thomas.abraham@linaro.org>
	(Thomas Abraham's message of "Thu, 16 Aug 2012 21:19:29 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Thomas,

On Thu, Aug 16 2012, Thomas Abraham wrote:
> Add device tree based discovery support for Samsung's sdhci controller
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c |  146 ++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 140 insertions(+), 6 deletions(-)

I know your initial version was submitted before we adopted a set of
standard MMC DT bindings, but now that those bindings exist this code
should be using them -- there should be a new file:
   Documentation/devicetree/bindings/mmc/sdhci-s3c.txt
describing differences between the mmc.txt bindings and this driver's.

Also, you didn't include a patch changelog, so I can't tell whether this
contains changes against your v3 of this patch; please do that.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
