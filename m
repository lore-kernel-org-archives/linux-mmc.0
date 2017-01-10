From: "S. Gilles" <sgilles@math.umd.edu>
Subject: Re: [BUG] Boot failure since df9bcc2bc on veyron_speedy
Date: Mon, 9 Jan 2017 20:04:34 -0500
Message-ID: <20170110010434.GE13205@number18.npnth.net>
References: <20170109141955.GB13205@number18.npnth.net>
 <20170109144937.GC13205@number18.npnth.net>
 <f30b97b0-d0e2-b6dd-e11e-ca4ea592b18d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f30b97b0-d0e2-b6dd-e11e-ca4ea592b18d@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2017-01-10T08:47:16+0800, Shawn Lin wrote:
> Hi
> 
> On 2017/1/9 22:49, S. Gilles wrote:
> > On 2017-01-09T09:19:55-0500, S. Gilles wrote:
> > > Hi,
> > > 
> > > I have a C201, a veyron_speedy device (which uses rk3288) running vanilla
> > > kernels. With recent kernels it will fail to boot (screen is on, with
> > > blinking cursor, but no login prompt and the machine does not respond
> > > over ssh).
> > > 
> > > I've bisected this to df9bcc2bc0a1f8d2963bd916698268fb2470713b, and
> > > reverting that commit on -mainline gives me a bootable kernel. I can
> > > provide more information as needed.
> > 
> 
> The fix is on the way,
> 
> https://patchwork.kernel.org/patch/9498527/

Great - thanks for letting me know.

Thanks,
S. Gilles
