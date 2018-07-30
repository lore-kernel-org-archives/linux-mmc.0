From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
Date: Mon, 30 Jul 2018 09:10:11 +0300
Message-ID: <0c1215a2-b8b3-e315-71e1-04501d02ba42@intel.com>
References: <1532794529-30137-1-git-send-email-srinath.mannam@broadcom.com>
 <201807290127.DcHKtABy%fengguang.wu@intel.com>
 <CABe79T5o431_XkKzh=zEfoPzs6pfMHrrTZGPW7218tekLkk=vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABe79T5o431_XkKzh=zEfoPzs6pfMHrrTZGPW7218tekLkk=vw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Vikram Prakash <vikram.prakash@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30/07/18 09:02, Srinath Mannam wrote:
> Hi Adrian Hunter,
> 
> Auto build error came to this patch, because it is depend on the
> patch "mmc: sdhci-pltfm: Convert DT properties to generic device properties"
> you have given to me.
> 
> Can I send my patch along with your patch in a single patch series?

Yes, that is normally how it is done.

> Please advice.
> 
> Regards,
> Srinath.
> 
> 
> On Sat, Jul 28, 2018 at 11:02 PM, kbuild test robot <lkp@intel.com> wrote:
>> Hi Srinath,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on ulf.hansson-mmc/next]
>> [also build test ERROR on v4.18-rc6 next-20180727]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Srinath-Mannam/mmc-host-iproc-Add-ACPI-support-to-IPROC-SDHCI/20180729-003026
>> base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>> config: ia64-allmodconfig (attached as .config)
>> compiler: ia64-linux-gcc (GCC) 8.1.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=8.1.0 make.cross ARCH=ia64
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/mmc/host/sdhci-iproc.c: In function 'sdhci_iproc_probe':
>>>> drivers/mmc/host/sdhci-iproc.c:304:2: error: implicit declaration of function 'sdhci_get_property'; did you mean 'sdhci_get_of_property'? [-Werror=implicit-function-declaration]
>>      sdhci_get_property(pdev);
>>      ^~~~~~~~~~~~~~~~~~
>>      sdhci_get_of_property
>>    cc1: some warnings being treated as errors
>>
>> vim +304 drivers/mmc/host/sdhci-iproc.c
>>
>>    276
>>    277  static int sdhci_iproc_probe(struct platform_device *pdev)
>>    278  {
>>    279          struct device *dev = &pdev->dev;
>>    280          const struct sdhci_iproc_data *iproc_data = NULL;
>>    281          struct sdhci_host *host;
>>    282          struct sdhci_iproc_host *iproc_host;
>>    283          struct sdhci_pltfm_host *pltfm_host;
>>    284          int ret;
>>    285
>>    286          if (dev->of_node)
>>    287                  iproc_data = of_device_get_match_data(dev);
>>    288          else if (has_acpi_companion(dev))
>>    289                  iproc_data = acpi_device_get_match_data(dev);
>>    290
>>    291          if (!iproc_data)
>>    292                  return -ENODEV;
>>    293
>>    294          host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>>    295          if (IS_ERR(host))
>>    296                  return PTR_ERR(host);
>>    297
>>    298          pltfm_host = sdhci_priv(host);
>>    299          iproc_host = sdhci_pltfm_priv(pltfm_host);
>>    300
>>    301          iproc_host->data = iproc_data;
>>    302
>>    303          mmc_of_parse(host->mmc);
>>  > 304          sdhci_get_property(pdev);
>>    305
>>    306          host->mmc->caps |= iproc_host->data->mmc_caps;
>>    307
>>    308          if (dev->of_node) {
>>    309                  pltfm_host->clk = devm_clk_get(dev, NULL);
>>    310                  if (IS_ERR(pltfm_host->clk)) {
>>    311                          ret = PTR_ERR(pltfm_host->clk);
>>    312                          goto err;
>>    313                  }
>>    314                  ret = clk_prepare_enable(pltfm_host->clk);
>>    315                  if (ret) {
>>    316                          dev_err(dev, "failed to enable host clk\n");
>>    317                          goto err;
>>    318                  }
>>    319          }
>>    320
>>    321          if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>>    322                  host->caps = iproc_host->data->caps;
>>    323                  host->caps1 = iproc_host->data->caps1;
>>    324          }
>>    325
>>    326          ret = sdhci_add_host(host);
>>    327          if (ret)
>>    328                  goto err_clk;
>>    329
>>    330          return 0;
>>    331
>>    332  err_clk:
>>    333          if (dev->of_node)
>>    334                  clk_disable_unprepare(pltfm_host->clk);
>>    335  err:
>>    336          sdhci_pltfm_free(pdev);
>>    337          return ret;
>>    338  }
>>    339
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
