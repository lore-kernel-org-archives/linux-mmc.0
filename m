From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor 	autoloading
 feature
Date: Mon, 10 May 2010 08:09:00 -0500
Message-ID: <4BE8056C.6080106@ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>	 <v2n7f9d1ffb1005060202r91efbe3habb936f75227ffa6@mail.gmail.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387482@dbde02.ent.ti.com>	 <004501caed38$03e7b9f0$544ff780@am.dhcp.ti.com>	 <EAF47CD23C76F840A9E7FCE10091EFAB02C538792A@dbde02.ent.ti.com>	 <000601caee06$b2c8a9b0$544ff780@am.dhcp.ti.com>	 <4BE4694F.3060901@ti.com>	 <x2r618f0c911005090351meff49918t941a904edb8027c3@mail.gmail.com>	 <4BE6DD8D.6030201@gmail.com> <i2h618f0c911005100531y94ddfd07l707946d460f357af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <i2h618f0c911005100531y94ddfd07l707946d460f357af@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, kishore kadiyala <kishorek.kadiyala@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 05/10/2010 07:31 AM, Venkatraman S wrote:
> Nishanth Menon<menon.nishanth@gmail.com>  wrote:

>>>> Please see [1] for SOC specific feature handling. any reasons we can't
>>>> handle it by adding a new feature?
>>>>
>>>> [1]
>>>>
>>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/include/plat/cpu.h#l439
>>>>
>>>
>>> Thanks. I can add a new feature here, but I see that the API is tied
>>> to OMAP3, whereas the DMA feature is common
>>> to 3630, OMAP4 and mostly everything after that. I can work on an
>>> upgrade, but do you see that
>>> as a dependency and done on the context of this patch ?
>>> Regards,
>>> Venkat.
>>
>> Yes, I am aware that the current APIs are tied to OMAP3, no reason that we
>> cant introduce a OMAP version independent feature.. Yes, IMHO, this is an
>> SOC specific feature that has no place in a platform data.. lets not misuse
>> that.
>> Regards,
>> NM
>
>
> Draft patch for this is here (Tested ok). I will post this as part of
> the series if this looks ok...
> This doesn't have all existing feature checks for OMAP4, but they seem to be not
> needed/used anyway..

NAK. DO NOT DO two logically exclusive things in a single patch:
a) you are switching omap3_features to omap_features
b) you are introducing sdma feature for the same.

please split and post to l-o for review as a proper patch.

>
> ---
>   arch/arm/mach-omap2/clock3xxx_data.c  |    2 -
>   arch/arm/mach-omap2/id.c              |   25 +++++++++++++++--------
>   arch/arm/plat-omap/include/plat/cpu.h |   36 +++++++++++++++++-----------------
>   3 files changed, 36 insertions(+), 27 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/id.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/id.c	2010-05-09
> 23:29:28.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/id.c	2010-05-10 17:39:29.000000000 +0530
> @@ -28,7 +28,7 @@
>   static struct omap_chip_id omap_chip;
>   static unsigned int omap_revision;
>
> -u32 omap3_features;
> +u32 omap_features;
>
>   unsigned int omap_rev(void)
>   {
> @@ -161,14 +161,14 @@
>   #define OMAP3_CHECK_FEATURE(status,feat)				\
>   	if (((status&  OMAP3_ ##feat## _MASK) 				\
>   		>>  OMAP3_ ##feat## _SHIFT) != FEAT_ ##feat## _NONE) { 	\
> -		omap3_features |= OMAP3_HAS_ ##feat;			\
> +		omap_features |= OMAP_HAS_ ##feat;			\
>   	}
>
>   void __init omap3_check_features(void)
>   {
>   	u32 status;
>
> -	omap3_features = 0;
> +	omap_features = 0;
>
>   	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
>
> @@ -178,7 +178,7 @@
>   	OMAP3_CHECK_FEATURE(status, NEON);
>   	OMAP3_CHECK_FEATURE(status, ISP);
>   	if (cpu_is_omap3630())
> -		omap3_features |= OMAP3_HAS_192MHZ_CLK;
> +		omap_features |= OMAP_HAS_192MHZ_CLK | OMAP_HAS_SDMA_DLOAD;
>
>   	/*
>   	 * TODO: Get additional info (where applicable)
> @@ -267,6 +267,12 @@
>   	}
>   }
>
> +void __init omap4_check_features(void)
> +{
> +	omap_features = OMAP_HAS_SDMA_DLOAD;
> +
> +}
> +
>   void __init omap4_check_revision(void)
>   {
>   	u32 idcode;
> @@ -294,7 +300,7 @@
>   }
>
>   #define OMAP3_SHOW_FEATURE(feat)		\
> -	if (omap3_has_ ##feat())		\
> +	if (omap_has_ ##feat())		\
>   		printk(#feat" ");
>
>   void __init omap3_cpuinfo(void)
> @@ -314,20 +320,20 @@
>   		/*
>   		 * AM35xx devices
>   		 */
> -		if (omap3_has_sgx()) {
> +		if (omap_has_sgx()) {
>   			omap_revision = OMAP3517_REV(rev);
>   			strcpy(cpu_name, "AM3517");
>   		} else {
>   			/* Already set in omap3_check_revision() */
>   			strcpy(cpu_name, "AM3505");
>   		}
> -	} else if (omap3_has_iva()&&  omap3_has_sgx()) {
> +	} else if (omap_has_iva()&&  omap_has_sgx()) {
>   		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
>   		strcpy(cpu_name, "OMAP3430/3530");
> -	} else if (omap3_has_iva()) {
> +	} else if (omap_has_iva()) {
>   		omap_revision = OMAP3525_REV(rev);
>   		strcpy(cpu_name, "OMAP3525");
> -	} else if (omap3_has_sgx()) {
> +	} else if (omap_has_sgx()) {
>   		omap_revision = OMAP3515_REV(rev);
>   		strcpy(cpu_name, "OMAP3515");
>   	} else {
> @@ -386,6 +392,7 @@
>   		return;
>   	} else if (cpu_is_omap44xx()) {
>   		omap4_check_revision();
> +		omap4_check_features();
>   		return;
>   	} else {
>   		pr_err("OMAP revision unknown, please fix!\n");
> Index: linux-omap-2.6/arch/arm/plat-omap/include/plat/cpu.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/plat/cpu.h	2010-05-09
> 23:24:15.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/plat/cpu.h	2010-05-10
> 17:53:04.000000000 +0530
> @@ -434,28 +434,30 @@
>   void omap2_check_revision(void);
>
>   /*
> - * Runtime detection of OMAP3 features
> + * Runtime detection of OMAP features
>    */
> -extern u32 omap3_features;
> +extern u32 omap_features;
>
> -#define OMAP3_HAS_L2CACHE		BIT(0)
> -#define OMAP3_HAS_IVA			BIT(1)
> -#define OMAP3_HAS_SGX			BIT(2)
> -#define OMAP3_HAS_NEON			BIT(3)
> -#define OMAP3_HAS_ISP			BIT(4)
> -#define OMAP3_HAS_192MHZ_CLK		BIT(5)
> +#define OMAP_HAS_L2CACHE		BIT(0)
> +#define OMAP_HAS_IVA			BIT(1)
> +#define OMAP_HAS_SGX			BIT(2)
> +#define OMAP_HAS_NEON			BIT(3)
> +#define OMAP_HAS_ISP			BIT(4)
> +#define OMAP_HAS_192MHZ_CLK		BIT(5)
> +#define OMAP_HAS_SDMA_DLOAD		BIT(6)
>
> -#define OMAP3_HAS_FEATURE(feat,flag)			\
> -static inline unsigned int omap3_has_ ##feat(void)	\
> +#define OMAP_HAS_FEATURE(feat, flag)			\
> +static inline unsigned int omap_has_ ##feat(void)	\
>   {							\
> -	return (omap3_features&  OMAP3_HAS_ ##flag);	\
> +	return (omap_features&  OMAP_HAS_ ##flag);	\
>   }							\
>
> -OMAP3_HAS_FEATURE(l2cache, L2CACHE)
> -OMAP3_HAS_FEATURE(sgx, SGX)
> -OMAP3_HAS_FEATURE(iva, IVA)
> -OMAP3_HAS_FEATURE(neon, NEON)
> -OMAP3_HAS_FEATURE(isp, ISP)
> -OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> +OMAP_HAS_FEATURE(l2cache, L2CACHE)
> +OMAP_HAS_FEATURE(sgx, SGX)
> +OMAP_HAS_FEATURE(iva, IVA)
> +OMAP_HAS_FEATURE(neon, NEON)
> +OMAP_HAS_FEATURE(isp, ISP)
> +OMAP_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> +OMAP_HAS_FEATURE(sdma_dload, SDMA_DLOAD)

>
>   #endif
> Index: linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock3xxx_data.c	2010-05-10
> 14:41:39.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock3xxx_data.c	2010-05-10
> 14:41:50.000000000 +0530
> @@ -3510,7 +3510,7 @@
>   			cpu_clkflg |= CK_3430ES2;
>   		}
>   	}
> -	if (omap3_has_192mhz_clk())
> +	if (omap_has_192mhz_clk())
>   		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
>
>   	if (cpu_is_omap3630()) {

