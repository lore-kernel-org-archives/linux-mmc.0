From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Wed, 28 Mar 2012 09:09:10 +0800
Message-ID: <20120328010909.GA2619@ladygaga>
References: <1332482196-22572-1-git-send-email-subhashj@codeaurora.org>
 <20120326031723.GA22292@ladygaga>
 <000401cd0b17$fcf7bd20$f6e73760$@codeaurora.org>
 <000601cd0b19$f136c9c0$d3a45d40$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000601cd0b19$f136c9c0$d3a45d40$@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, arindam.nath@amd.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Mar 26, 2012 at 12:00:27PM +0530, Subhash Jadavani wrote:
> > Actually we are already printing the HS200/DDR (for eMMC) bus speed mode
> > along with card detected print. So why not bus speed mode for UHS-I cards.
> > It really gives good impression to user what this card is capable of doing
> by
> > just looking at this print.
> > Correct we can this information from /sys/kernel/debug/mmc/ios but this
> > needs extra effort than just looking at the kernel logs.
> 
> But still please check if this point makes sense?
>

Yes, I think this makes sense.

-Aaron
 
