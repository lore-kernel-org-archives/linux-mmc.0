From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc sdhci mmcblk0: error -110 sending status command, retrying
Date: Tue, 07 Feb 2012 13:04:09 +0200
Message-ID: <4F310529.4020101@intel.com>
References: <CAAJw_ZsryUFFFRCKdd9sQ7_38hjpVq37b6hhZDX5=qz8x1B+EQ@mail.gmail.com> <m2pqdr2tyq.fsf@bob.laptop.org> <CAAJw_Zv4Hk_kfc33xsVcdi-0_C6tsf_FD3sUx1JPDX_fZZMzeQ@mail.gmail.com> <4F30E19B.9020503@intel.com> <CAAJw_Zth+QM8OhMEWweBBek8QNW_9CseHSDuB-LCGrvwuqfV2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAJw_Zth+QM8OhMEWweBBek8QNW_9CseHSDuB-LCGrvwuqfV2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Pierre Ossman <pierre@ossman.eu>, lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, zhangfei.gao@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 07/02/12 12:40, Jeff Chua wrote:
> On Tue, Feb 7, 2012 at 4:32 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Looks like Caps_1: 0x00008073 means re-tuning mode 3.  Maybe the tuning is
>> not being done correctly.
> 
> What I can do to test it?

Tuning may be needed for UHS (ultra high speed).
Was there a message like:

	mmc0: new ultra high speed SDHC card
