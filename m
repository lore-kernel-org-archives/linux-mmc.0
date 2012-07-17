From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/6] mmc: dw_mmc: add device tree support
Date: Tue, 17 Jul 2012 15:51:21 +0530
Message-ID: <CAJuYYwRzAB0eUm5xV1PiB01wKXJq2efYJPczgw0EAangQLNEew@mail.gmail.com>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
 <1342097668-25243-6-git-send-email-thomas.abraham@linaro.org>
 <87liikjpw0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87liikjpw0.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
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
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 16 July 2012 09:53, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Thu, Jul 12 2012, Thomas Abraham wrote:
>> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> new file mode 100644
>> index 0000000..3acd6c9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> @@ -0,0 +1,108 @@
>> +* Synopsis Designware Mobile Storage Host Controller
>> +
>> +The Synopsis designware mobile storage host controller is used to interface
>> +a SoC with storage medium such as eMMC or SD/MMC cards.
>> +
>> +Required Properties:
>> +
>> +* compatible: should be one of the following
>> +     - snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
>> +
>> +* reg: physical base address of the dw-mshc controller and size of its memory
>> +  region.
>> +
>> +* interrupts: interrupt specifier for the controller. The format and value of
>> +  the interrupt specifier depends on the interrupt parent for the controller.
>
> Please instead add:
>
> This file documents differences between the core properties described
> by mmc.txt and the properties used by the dw_mmc driver.
>
> mmc.txt already describes compatible, reg, interrupts, bus-width,
> cd-gpios, and wp-gpios, so you don't need to describe those again.

Ok. I will change it.

>
>> +     cnt = sizeof(of_quriks) / sizeof(struct dw_mci_of_quirks);
>> +     for (idx = 0; idx < cnt; idx++)
>> +             if (of_get_property(np, of_quriks[idx].quirk, NULL))
>> +                     pdata->quirks |= of_quriks[idx].id;
>
> of_quirks, not of_quriks.

Yes, thanks for pointing this out. I will fix this.

Thanks,
Thomas.
