From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
Date: Tue, 5 May 2015 14:12:32 +0530
Message-ID: <CAOHikRAviwD=kPQpHeR5NCXdANWH8B+DqNW=qJQ0ACpeOppU2A@mail.gmail.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
	<CAPDyKFqva7jioEpf1qBv+sSo9-ZWU69+wb9qTF1X+4cxOgf2uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqva7jioEpf1qBv+sSo9-ZWU69+wb9qTF1X+4cxOgf2uQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 5, 2015 at 2:06 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 4 May 2015 at 15:39, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org> wrote:
>> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
>>
>> v1 change:
>>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
>>
>> v2 change:
>>  * Drop the IOMMU support and switching to PIO mode for arasan.
>>    controller integrated inside APM X-Gene SoC.
>>
>> v3 change:
>>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>>  * Add quirks for arasan4.9a.
>>
>> v4 change:
>>  * Cleanup the Documentation and dts.
>>
>> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>> ---
>>
>> Suman Tripathi (3):
>>   arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
>>   mmc: host: arasan: Add the support for sdhci-arasan4.9a in
>>     sdhci-of-arasan.c
>>   Documentation: mmc: Update Arasan SDHC documentation to support 4.9a
>>     version of     Arasan SDHC controller.
>>
>>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  3 +-
>>  arch/arm64/boot/dts/apm-mustang.dts                |  4 ++
>>  arch/arm64/boot/dts/apm-storm.dtsi                 | 44 ++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-of-arasan.c                 |  7 ++++
>>  4 files changed, 57 insertions(+), 1 deletion(-)
>>
>
> Thanks!
>
> I have applied patch2 and patch3. Though, I decided to squash them
> into one patch and changed the commit message header a bit.
>
> I couldn't apply patch 1, so I guess that will be taken through arm soc?

why it couldn't be applied?? I made it in top of

git git://git.linaro.org/people/ulf.hansson/mmc.git

Is this not correct ??

>
> Kind regards
> Uffe



-- 
Thanks,
with regards,
Suman Tripathi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
