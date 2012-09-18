From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] mmc: sdhci-s3c: Add device tree support
Date: Mon, 17 Sep 2012 23:50:54 -0400
Message-ID: <m3lig8kmzl.fsf@pullcord.laptop.org>
References: <1345741809-18599-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwRz8mBXefLsuM9D47KxS2iqK6x6YWtjaaEwro7dq5C0_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAJuYYwRz8mBXefLsuM9D47KxS2iqK6x6YWtjaaEwro7dq5C0_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 (Thomas Abraham's message of "Tue, 18 Sep 2012 07:15:22 +0530")
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Sep 17 2012, Thomas Abraham wrote:
> On 23 August 2012 22:40, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Add device tree based discovery support for Samsung's sdhci controller
>>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> Changes since v4:
>> Adapted to new mmc core card detection bindings as specfied in the patch:
>> [PATCH] mmc: dt: Add card-detection properties to core binding
>> and extends it "samsung,cd-pinmux-gpio" property as suggested by
>> Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
>>
>> Changes since v3:
>>
>> The patch series that adds device tree support for Samsung sdhci controller
>> had six patches in total, of which, the first five patches have been accepted.
>> The sixth patch in the series was dropped since it was using custom Samsung
>> properties for descrbing the bus-width and card-detect gpio, but had otherwise
>> addressed all the comments.
>>
>> This patch reworks the sixth patch in v3 of the sdhci device tree support
>> patch series. The only change in this patch from the v3 version is the use of
>> generic mmc bindings for descrbing the bus-width and card-detect gpio.
>>
>>  .../devicetree/bindings/mmc/samsung-sdhci.txt      |   53 +++++++
>>  drivers/mmc/host/sdhci-s3c.c                       |  162 +++++++++++++++++++-
>>  2 files changed, 209 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt
>
> Hi Chris,
>
> This patch adds device tree support for sdhci-s3c driver. All the
> comments for this patch has been addressed. Can this be queued for
> v3.7?

Yes, sounds good.  Jaehoon, perhaps you could give your Reviewed-by
for me to add to the patch?  I've pushed this to mmc-next for 3.7
now, after adding Jaehoon's else-if suggestion that wasn't acted on:

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 3d91c7a..0c77b10 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -461,22 +461,18 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
 	if (gpio_is_valid(gpio)) {
 		pdata->cd_type = S3C_SDHCI_CD_GPIO;
 		goto found_cd;
-	} else {
-		if (gpio != -ENOENT) {
-			dev_err(dev, "invalid card detect gpio specified\n");
-			return -EINVAL;
-		}
+	} else if (gpio != -ENOENT) {
+		dev_err(dev, "invalid card detect gpio specified\n");
+		return -EINVAL;
 	}
 
 	gpio = of_get_named_gpio(node, "samsung,cd-pinmux-gpio", 0);
 	if (gpio_is_valid(gpio)) {
 		pdata->cd_type = S3C_SDHCI_CD_INTERNAL;
 		goto found_cd;
-	} else {
-		if (gpio != -ENOENT) {
-			dev_err(dev, "invalid card detect gpio specified\n");
-			return -EINVAL;
-		}
+	} else if (gpio != -ENOENT) {
+		dev_err(dev, "invalid card detect gpio specified\n");
+		return -EINVAL;
 	}
 
 	dev_info(dev, "assuming no card detect line available\n");

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
