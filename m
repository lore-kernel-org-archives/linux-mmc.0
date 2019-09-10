From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
Date: Tue, 10 Sep 2019 11:27:09 +0800
Message-ID: <CAMz4kuLLjDC_bLpen9qEsxEJTF5WWg9zsH_J-3Xp=Mj_Wss7Eg@mail.gmail.com>
References: <cover.1567740135.git.baolin.wang@linaro.org> <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com> <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
 <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 9 Sep 2019 at 20:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 9/09/19 3:16 PM, Baolin Wang wrote:
> > Hi Adrian,
> >
> > On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 6/09/19 6:52 AM, Baolin Wang wrote:
> >>> Now the MMC read/write stack will always wait for previous request is
> >>> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> >>> or queue a work to complete request, that will bring context switching
> >>> overhead, especially for high I/O per second rates, to affect the IO
> >>> performance.
> >>>
> >>> Thus this patch introduces virtual command queue interface, which is
> >>> similar with the hardware command queue engine's idea, that can remove
> >>> the context switching.
> >>
> >> CQHCI is a hardware interface for eMMC's that support command queuing.  What
> >> you are doing is a software issue queue, unrelated to CQHCI.  I think you
> >
> > Yes.
> >
> >> should avoid all reference to CQHCI i.e. call it something else.
> >
> > Since its process is similar with CQHCI and re-use the CQHCI's
> > interfaces, I called it virtual command queue. I am not sure what else
> > name is better, any thoughts? VCQHCI? Thanks.
>
> What about swq for software queue.  Maybe Ulf can suggest something?

Um, though changing to use swq, still need reuse command queue's
interfaces, like 'mq->use-cqe', 'host->cqe_depth' and cqe ops and so
on, looks a little weird for me. But if you all agree with this name,
then I am okay. Ulf, what do you suggest?

-- 
Baolin Wang
Best Regards
