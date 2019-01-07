From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Date: Mon, 7 Jan 2019 14:42:09 +0200
Message-ID: <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-10-okaya@kernel.org>
 <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Cercueil <paul@crapouillou.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Faiz Abbas <faiz_abbas@ti.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ludovic Barre <ludovic.barre@st.com>, Arnd Bergmann <arnd@arndb.de>, Alex Smith <alex.smith@imgtec.com>, Chris Brandt <chris.brandt@renesas.com>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
List-Id: linux-mmc@vger.kernel.org

On 7/01/19 1:17 PM, Rafael J. Wysocki wrote:
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
>> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>  drivers/mmc/host/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index e26b8145efb3..1b9401fe94c0 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
>>
>>  config MMC_SDHCI_ACPI
>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>> -       depends on MMC_SDHCI && ACPI
>> +       depends on MMC_SDHCI && ACPI && PCI
>>         select IOSF_MBI if X86
>>         help
>>           This selects support for ACPI enumerated SDHCI controllers,
>> --
> 
> Any objections against this one from anyone?

+ QCOM and AMD contributors
