From: Chris Ball <cjb@laptop.org>
Subject: Re: FW: [PATCH v1 0/3] SDIO fixes
Date: Mon, 14 Jan 2013 14:07:25 -0500
Message-ID: <87txqjtwgi.fsf@laptop.org>
References: <1354620980-23764-1-git-send-email-subhashj@codeaurora.org>
	<50C7271D.2080704@codeaurora.org>
	<86988B169C1CD04598F5B80198CCE50E738D93@aphydexd01b>
	<50C729FB.1090107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <50C729FB.1090107@codeaurora.org> (Subhash Jadavani's message of
	"Tue, 11 Dec 2012 18:11:31 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-msm@vger.kernel.org, johan.rudholm@stericsson.com, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,

On Tue, Dec 11 2012, Subhash Jadavani wrote:
> This patch-series is having 1 fix for SDIO resume and 2 fixes related to SDIO3.0 card detection
>
> Subhash Jadavani (2):
>     mmc: sdio: fix resume failure
>     mmc: sdio: print correct UHS mode during card detection
>
> Sujit Reddy Thumma (1):
>     mmc: sdio: Fix SDIO 3.0 UHS-I initialization sequence
>
>    drivers/mmc/core/sdio.c  |   33 ++++++++++++++++++++-------------
>    include/linux/mmc/host.h |    8 ++++++++
>    2 files changed, 28 insertions(+), 13 deletions(-)

Thanks, pushed all three patches to mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
