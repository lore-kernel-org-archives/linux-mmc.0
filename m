From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
Date: Fri, 27 Jun 2014 20:19:26 +0900
Message-ID: <001201cf91f9$a7924920$f6b6db60$%jun@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-2-git-send-email-yuvaraj.cd@samsung.com>
 <CAD=FV=UGjm9y3XoBgWKjw9kp9W=ZrwB-S6Lh7T_LBUgCQZn1ag@mail.gmail.com>
 <53AA3F78.3080804@samsung.com>
 <001201cf9067$3c5b2070$b5116150$%jun@samsung.com>
 <CAD=FV=UCinFuZQW+_GYFw=M046ziTLRNvvHUvsx_GQ0kjw5DfQ@mail.gmail.com>
 <004f01cf9129$b4ac9690$1e05c3b0$%jun@samsung.com>
 <CAD=FV=VP6Exg-iJiAk=zNFpFzY8jFbU8HSR=wQQ7S+mfZWTJ=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42159 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbaF0LT2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jun 2014 07:19:28 -0400
In-reply-to: <CAD=FV=VP6Exg-iJiAk=zNFpFzY8jFbU8HSR=wQQ7S+mfZWTJ=Q@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Sonny Rao' <sonnyrao@chromium.org>, 'Tomasz Figa' <t.figa@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, ks.giri@samsung.com, 'Prashanth G' <prashanth.g@samsung.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>

On Fri, June 27, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Thu, Jun 26, 2014 at 3:30 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Hi Doug,
> >
> > On Thu, June 26, 2014, Doug Anderson wrote:
> >> Seungwon,
> >>
> >> On Wed, Jun 25, 2014 at 4:18 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> >> >> +       case MMC_POWER_ON:
> >> >> >> +               if (!IS_ERR(mmc->supply.vqmmc) &&
> >> >> >> +                               !test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
> >> > You can use regulator_is_enabled() instead of flag bit, DW_MMC_IO_POWERED.
> >>
> >> I'd be a little worried about regulator_is_enabled() since regulators
> >> are reference counted.  What if someone else is sharing this
> >> regulator?  The regulator might happen to be enabled when you check it
> >> but unless you add your own dw_mmc reference count they might turn it
> >> off.
> > Cool, that's a possibility. Some assumption may need.
> > If mmc's core can guarantee its balance, I think we don't need to consider some flag.
> 
> I notice that the mmc core seems to keep a flag itself for vdd (the
> mmc->regulator_enabled flag).  That would imply that the core thought
> it was important to have the extra flag and that we should keep our
> own flag for vqmmc.
Ok, Good.

Thanks,
Seungwon Jeon
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

