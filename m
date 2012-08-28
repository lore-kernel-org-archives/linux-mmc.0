From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4 0/9] mmc: dw_mmc: add support for device tree based instantiation
Date: Tue, 28 Aug 2012 10:22:51 +0530
Message-ID: <CAJuYYwT5C00NSxAR+ZEt9b_UsBjdMZg6wEwRPaWUnwpZ-zxOcQ@mail.gmail.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
	<CAFbHwiQgs4fwGWMRNWct0xo1JrGwzr2SYRkDyGA5iXpCp+9UJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAFbHwiQgs4fwGWMRNWct0xo1JrGwzr2SYRkDyGA5iXpCp+9UJg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 27 August 2012 15:01, Will Newton <will.newton@gmail.com> wrote:
> On Sun, Aug 26, 2012 at 12:51 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> This is the fourth version of the patch series that adds device tree support
>> for Synopsis Designware Mobile Storage Host Controller. In this version, the
>> significant change is the spliting of Exynos specific code into a seperate
>> file, as suggested by Seungwon Jeon <tgih.jun@samsung.com>. Spliting the
>> Exynos specific code into a seperate file did infact keeps the core driver
>> code clean, which otherwise was littered with Exynos specific code. I hope
>> the changes look sane, though. This has been tested only on smdk5250 board.
>>
>> Thomas Abraham (9):
>>   mmc: dw_mmc: convert copy of struct device in struct dw_mci to a reference
>>   mmc: dw_mmc: Use devm_* functions in dw_mmc platform driver
>>   mmc: dw_mmc: allow probe to succeed even if one slot is initialized
>>   mmc: dw_mmc: lookup for optional biu and ciu clocks
>>   mmc: dw_mmc: add quirk to indicate missing write protect line
>>   mmc: dw_mmc: add device tree support
>>   mmc: dw_mmc: prepare functions in dw_mmc-pltfm for reuse
>>   mmc: dw_mmc: add support for implementation specific callbacks
>>   mmc: dw_mmc: add support for exynos specific implementation of dw-mshc
>>
>>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   79 ++++++
>>  .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |   90 ++++++
>>  drivers/mmc/host/Kconfig                           |    9 +
>>  drivers/mmc/host/Makefile                          |    3 +-
>>  drivers/mmc/host/dw_mmc-exynos.c                   |  247 +++++++++++++++++
>>  drivers/mmc/host/dw_mmc-pci.c                      |    2 +-
>>  drivers/mmc/host/dw_mmc-pltfm.c                    |   62 +++--
>>  drivers/mmc/host/dw_mmc-pltfm.h                    |   20 ++
>>  drivers/mmc/host/dw_mmc.c                          |  287 ++++++++++++++++----
>>  drivers/mmc/host/dw_mmc.h                          |   22 ++
>>  include/linux/mmc/dw_mmc.h                         |   13 +-
>>  11 files changed, 757 insertions(+), 77 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>>  create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>>  create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
>>  create mode 100644 drivers/mmc/host/dw_mmc-pltfm.h
>
> This series looks good to me, although I am not familiar enough with
> the device tree stuff to review it in a meaningful way.
>
> Acked-by: Will Newton <will.newton@imgtec.com>
>
> Note that the platform driver changes will conflict with Jaehoon
> Chung's patch to fix a section mismatch in that file. Have you tried
> building this as a module and with section mismatch debugging to make
> sure the new code does not add any mismatches?

Thanks Will for reviewing this patch series.

I tried building dw-mmc, dw-mmc-pltfm and dw-mmc-exynos as modules
with section mismatch debugging enabled, and there were no warnings.
But, I did find a problem with the Kconfig entry I made for
dw-mmc-exynos file, instead of 'bool', I should have used 'tristate'.
I will fix this and other comments and repost.

Thanks,
Thomas.
