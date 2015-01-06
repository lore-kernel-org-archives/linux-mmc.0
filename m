From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and
 add IOMMU support.
Date: Tue, 6 Jan 2015 17:10:29 +0530
Message-ID: <CAOHikRCV7RaxJz-A_s6g++ueg3CDe9Jrqcog1Lc2_+KXR9QqnQ@mail.gmail.com>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com>
 <1418662867-9210-2-git-send-email-stripathi@apm.com>
 <3866536.C6OiUcuGCr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3866536.C6OiUcuGCr@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jon Masters <jcm@redhat.com>, anton@enomsg.org, linux-mmc@vger.kernel.org, chris@printf.net, patches@apm.com, Don Dutile <ddutile@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
>
> +#if defined(CONFIG_IOMMU_SUPPORT)
> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
> +       if (!sdhci_arasan->domain) {
> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
> +               return PTR_ERR(sdhci_arasan->domain);
> +       }
> +
> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
> +#endif
> +
>

Device drivers should never care about the implementation details
of the iommu. Please change the code to use the regular dma_map_*
interfaces that will work both with and without IOMMU.

After refer to iommu binding , there is a service that allows "Remap
address space to allow devices to access physical memory ranges that
they otherwise wouldn't be capable of accessing." eg : 32-bit to 64
bit DMA .

So do we have any existing driver that uses this service ? Just asking
for suggestions.

On Tue, Dec 16, 2014 at 2:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
>> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                 goto clk_dis_ahb;
>>         }
>>
>> +#if defined(CONFIG_IOMMU_SUPPORT)
>> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
>> +       if (!sdhci_arasan->domain) {
>> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
>> +               return PTR_ERR(sdhci_arasan->domain);
>> +       }
>> +
>> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
>> +#endif
>> +
>>
>
> Device drivers should never care about the implementation details
> of the iommu. Please change the code to use the regular dma_map_*
> interfaces that will work both with and without IOMMU.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
