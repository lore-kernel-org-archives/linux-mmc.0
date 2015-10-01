From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 1 Oct 2015 23:05:12 +0200
Message-ID: <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<17200614.QxCe8zAb7I@diego>
	<CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
	<2695161.Z1IhqPE0bd@diego>
	<20151001173554.GB19319@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36912 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961AbbJAVFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2015 17:05:13 -0400
Received: by wicfx3 with SMTP id fx3so6598904wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Oct 2015 14:05:12 -0700 (PDT)
In-Reply-To: <20151001173554.GB19319@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>

On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/01, Heiko St=C3=BCbner wrote:
>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
>> > On 30 September 2015 at 16:55, Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>> > > Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
>> > >> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de>=
 wrote:
>> > > The clock changes of course only touch internals of the phase-cl=
ocks, so
>> > > should have no problem going through another tree.
>> >
>> > What happens if I take mmc and dt changes, wouldn't I need the clo=
ck
>> > patches as well?
>>
>> The API stays of course the same, only the degree to settings transl=
ation gets
>> optimized, so I guess in the worst case you would get no good phase =
and thus
>> fall back to non-highspeed modes - but the system would stay running=
=2E
>>
>> But of course, if the clock maintainers could Ack the two clock patc=
hes and
>> everything would stay together that would work even better :-)
>>
>
> If Ulf doesn't want to take them we can apply them to clk tree.
> Otherwise, you can have my acked-by on the clk patches.

I don't mind picking up the clock patches. So I consider this as an
ack for both patch 1 and patch2, thanks.

Now, let's give Jaehoon some time to review the dw_mmc parts.

Kind regards
Uffe
