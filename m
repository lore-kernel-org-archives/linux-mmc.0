From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Date: Thu, 11 Feb 2016 14:32:13 +0100
Message-ID: <20160211133212.GA1656@katana>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
 <1453749316-1848-10-git-send-email-wsa@the-dreams.de>
 <CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
 <20160210163623.GA15453@katana>
 <CAPDyKFrzFA_3MnkOPGLD7Fy84XAyx7+=utERbNF1cX31KWxHMg@mail.gmail.com>
 <20160211000716.GA2058@tetsubishi>
 <CAPDyKFp-CMkqa-Y_C_z6bhA_KNm+6oQZhv3_f0bV8WoVDJHfVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp-CMkqa-Y_C_z6bhA_KNm+6oQZhv3_f0bV8WoVDJHfVg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 11, 2016 at 10:00:50AM +0100, Ulf Hansson wrote:
> On 11 February 2016 at 01:07, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> I suspect you are using a delayed work in this driver to deal with
> >> request timeouts.
> >>
> >> The value for the delay that is used, needs to be informed towards the
> >> mmc core via the "->max_busy_timeout".
> >
> > Shouldn't that be a seperate patch? In patch 9, I add support for
> > another SoC. But your requested change will affect all SoCs.
> 
> This is related to how the core treat hosts that announces
> MMC_CAP_WAIT_WHILE_BUSY.
> 
> Therefore max_busy_timeout needs to be set within the same patch.

Right. I assumed previous SoC (Gen2) were using MMC_CAP_WAIT_WHILE_BUSY
already, so this step would then have to be taken seperately to catch
all SoC. But I was wrong.

I meanwhile found the timeout bits which are present in Gen3 and also in
Gen2 and are currently unused by the driver. While this helps explaining
that the HW has internal busy detection, its full potential is not
implemented yet.

So, I am going to resend patch 9 without MMC_CAP_WAIT_WHILE_BUSY set and
will implement timeout handling incrementally as a seperate series.

Sounds good?
