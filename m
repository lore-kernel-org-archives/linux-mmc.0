From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 0/4] mmc: sdhci-msm: Add CQE support for sdhci-msm
Date: Thu, 31 Aug 2017 11:39:23 +0300
Message-ID: <e086ebd1-0602-f1bf-c586-55dbc99c1f73@intel.com>
References: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504098251-27739-1-git-send-email-riteshh@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 30/08/17 16:04, Ritesh Harjani wrote:
> Hi All,
> 
> Please ignore the previous patch series from a wrong email
> address. Stupid gitconfig issue. Apologies for the spam.
> 
> This is RFC patch series based on top of ulfh_mmc/cmdq branch
> which is based upon Adrian's CMDQ patch series.
> 
> Below patch series enables CQE for sdhci-msm platform.
> This has been tested on internal 8996 MTP which has CMDQ support.
> 
> Fixes w.r.t. CMDQ:-
> There are some patches identified which were required atleast on
> MSM platform. I am not sure if these are required for any other
> CQE platform or not. Patchset 1, 3 & 4 commit text describes
> the problems.
> 
> Performance related:- 
> I gave one small shot for performance and the numbers were not looking good.
> So, unless I have tested for performance completely, I should not discuss 
> on performance numbers as of now with this patchset. 
> I can try doing some more performance testing and post the results -
> though this may take some while.

You might also need custom Send Status Configuration.

> 
> I used below test script for random read/write test.
> 
> *randwrite-test-script*
> [global]
> bs=32k
> size=1g
> rw=randwrite
> direct=1
> directory=/data/fiotest

Random write results can vary a lot.  It is important to know if the eMMC
has lots of un-mapped blocks or not. e.g. for ext4 is the "-o discard"
option being used.  I find I get more consistent results if I always have
discards enabled.

> 
> [file1]
> filename=singlefile1
> 
> *randread-test-script*
> [global]
> bs=32k
> size=1g
> rw=randread
> directory=/data/fiotest

If you don't set numjobs > 1 then there is little benefit of the queue.
Also still need direct=1

> 
> [file1]
> filename=singlefile1
> 
> @Adrian,
> Thanks a lot for pursuing and bringing CMDQ patch series to it's final stages :)
> 
> 
> Ritesh Harjani (4):
>   mmc: cqhci: Move CQHCI_ENABLE before setting TDLBA/TDLBAU
>   mmc: sdhci-msm: Add CQHCI support for sdhci-msm
>   mmc: sdhci-msm: Change the desc_sz on cqe_enable/disable.
>   mmc: sdhci-msm: Handle unexpected interrupt case on enabling legacy
>     IRQs on CQE halt
> 
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/cqhci.c                           |   7 +-
>  drivers/mmc/host/sdhci-msm.c                       | 121 ++++++++++++++++++++-
>  4 files changed, 125 insertions(+), 5 deletions(-)
> 
