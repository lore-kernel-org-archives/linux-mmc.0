From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: Add MMC software queue support
Date: Mon, 23 Sep 2019 15:53:44 +0800
Message-ID: <CAMz4kuJONoMYAmQrKukxxpDbYDQQ8G7SYaL4svk8A6ewr2sYEA@mail.gmail.com>
References: <63395d0c73f0bb1cf7c2f52545137fd4014f84ba.1568864712.git.baolin.wang@linaro.org>
 <20190921144922.GB13091@xsang-OptiPlex-9020>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190921144922.GB13091@xsang-OptiPlex-9020>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Sat, 21 Sep 2019 at 22:43, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190918]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/mmc-Add-MMC-software-queue-support/20190919-140107
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 hours ago
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/mmc/host/sqhci.o: in function `sqhci_finalize_request':
> >> (.text+0x644): undefined reference to `mmc_cqe_request_done'

OK. I will fix this issue in the next version and wait for a while to
see if there are any new comments for this patch set. Thanks.

-- 
Baolin Wang
Best Regards
