From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 2/4] mmc: core: implement enhanced strobe support
Date: Thu, 3 Mar 2016 15:37:13 +0200
Message-ID: <56D83E09.70008@intel.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
 <1456972596-8077-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456972596-8077-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 03/03/16 04:36, Shawn Lin wrote:
> Controllers use data strobe line to latch data from devices
> under hs400 mode, but not for cmd line. So from emmc 5.1, JEDEC
> introduces enhanced strobe mode for latching cmd response from
> emmc devices to host controllers. This new feature is optional.

As I currently understand it, HS400ES does not require tuning.
Consequently you can go straight to HS400ES and do not need to do
HS200 first.  If that is the case then more changes are needed.

Also it would be nice if the transfer mode displayed reflected enhanced
strobe e.g.

	Currently

		mmc1: new HS400 MMC card at address 0001

	Change for enhance strobe supported

		mmc1: new HS400ES MMC card at address 0001
