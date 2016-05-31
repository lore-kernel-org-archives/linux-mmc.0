From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: host: use pr_err for sdhci_dumpregs
Date: Tue, 31 May 2016 18:46:50 +0300
Message-ID: <CAHp75Veem2Dkrni8nYq7q-8h2GPUVQ-q7JOF_0OxDO6GGpSxCg@mail.gmail.com>
References: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 30, 2016 at 10:59 AM, Baranowska, BeataX
<beatax.baranowska@intel.com> wrote:
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>
> sdhci_dumpregs is used to dump registers when error happens. Thus it should
> use pr_err instead of pr_debug to show more information about the hardware.
>

Wouldn't be too noisy?

-- 
With Best Regards,
Andy Shevchenko
