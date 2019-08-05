From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v5] mmc: host: sdhci: Fix the incorrect soft reset
 operation when runtime resuming
Date: Mon, 5 Aug 2019 13:45:27 +0800
Message-ID: <CAMz4ku+appDGrAe9yLwzLunUy4K90O1ej2bvA5A=fMbVu_u7Xg@mail.gmail.com>
References: <74a6462743e3d73a630d2634880d8866daee333e.1564022625.git.baolin.wang@linaro.org>
 <CAPDyKFoNGZRdY3VVf6G9eNBfCyJbN5SUU2+fK24U-mHDX13oFQ@mail.gmail.com>
 <CAMz4kuKOGmGHoYNELG38qYOw71=AaSk33=johskUtOs0KZ0z-g@mail.gmail.com>
 <CAPDyKFrUxTzMr+aJ=mXcVJeiP8f4-8+wAxkbA9n8mJaAn=ftVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFrUxTzMr+aJ=mXcVJeiP8f4-8+wAxkbA9n8mJaAn=ftVA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2 Aug 2019 at 23:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 26 Jul 2019 at 03:41, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > On Thu, 25 Jul 2019 at 21:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > - Trimmed cc list
> > >
> > > On Thu, 25 Jul 2019 at 05:14, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > > The SD host controller specification defines 3 types software reset:
> > > > software reset for data line, software reset for command line and
> > > > software reset for all. Software reset for all means this reset affects
> > > > the entire Host controller except for the card detection circuit.
> > > >
> > > > In sdhci_runtime_resume_host() function, now we will always do software
> > > > reset for all, which will cause Spreadtrum host controller work abnormally
> > > > after resuming. For Spreadtrum platform that will not power down the SD/eMMC
> > > > card during runtime suspend, we should just do software reset for data
> > > > and command instead doing reset for all.
> > > >
> > > > To fix this issue, this patch introduces a new parameter of
> > > > sdhci_runtime_resume_host() to let it decide if a 'reset for all' shall
> > > > be done or not. Meanwhile changes other host drivers to issue a software
> > > > reset for all to keep the original logic.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > >
> > > Applied for next, with a little change (renaming the "soft"
> > > in-parameter to soft_reset), thanks!
> >
> > Thanks Ulf :)
> >
> > >
> > > Adrian, if there is anything you want to change, please tell.
> > >
> > > BTW, perhaps this should be applied for fixes and tagged for stable?
> > > Baolin, if so, can point me the commit (or stable tag) the patch
> > > fixes?
> >
> > Yes, since we fixed the PM runtime issue, which will reveal this
> > issue. And I think it still fixes:
> > Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
> > controller")
>
> Make sense. I moved this to the fixes branch and also to took the
> opportunity to clarify the changelog a bit.

Thanks Ulf.

-- 
Baolin Wang
Best Regards
