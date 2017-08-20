From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V5 02/13] mmc: core: Add members to mmc_request and
 mmc_data for CQE's
Date: Sun, 20 Aug 2017 13:29:59 +0200
Message-ID: <CACRpkda=q=9UhKnvK5Z2PF+kqa1L4CSdTzcr=xuiOUgG7z6sww@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1502366898-23691-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Most of the information needed to issue requests to a CQE is already in
> struct mmc_request and struct mmc_data. Add data block address, some flags,
> and the task id (tag), and allow for cmd being NULL which it is for CQE
> tasks.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

> +       int                     tag;

Is this consistent with the block layer idea of "tag"?

I am asking because I get confused.

I thought the block layers idea of a "tag" was some metadata
associated with a request. Not that I am a block layer expert.
Why can't we just name this "task_id" if that is what it is in
Linux terms? Does the specification call it "tag"?

Yours,
Linus Walleij
