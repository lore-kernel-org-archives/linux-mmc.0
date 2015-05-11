From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2 v2] mmc: cast to avoid unexpected error
Date: Mon, 11 May 2015 12:31:07 +0200
Message-ID: <CAPDyKFq60jNgaY==kEUfUhgPweC22KtA-6dD33mFag1qbzE_pQ@mail.gmail.com>
References: <redmine.issue-68414.20150330134838@dm.renesas.com>
	<redmine.journal-531718.20150406210913@dm.renesas.com>
	<87wq1n5bht.wl%kuninori.morimoto.gx@renesas.com>
	<87vbfz36yh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33819 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbbEKKbH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:31:07 -0400
Received: by qkgx75 with SMTP id x75so83533748qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:31:07 -0700 (PDT)
In-Reply-To: <87vbfz36yh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: ryusuke.sakato.bx@renesas.com, yoshihiro.shimoda.uh@renesas.com, hiroyuki.yokoyama.vx@renesas.com, takeshi.kihara.df@renesas.com, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 11 May 2015 at 09:34, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Hi Ulf
>
> These are v2 of mmc data cast patches which were posted in
> Subject: [PATCH 0/2][RFC] mmc: cast to avoid unexpected error
> Date: Wed, 8 Apr 2015 07:32:35 +0000
>
> These 2 patches adds cast to avoid unexpected error.
> It tries copy to u64 without cast.
> The data will be 0xfff... if last bit was 1.
> These are reported by coverity tool.
> I'm happy if someone tests it, or can get deep review.
>
> Kuninori Morimoto (2):
>       mmc: cast u8 to unsigned long long to avoid unexpected error
>       mmc: cast unsigned int to typeof(sector_t) to avoid unexpected error
>
>  drivers/mmc/card/block.c | 2 +-
>  drivers/mmc/core/mmc.c   | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Thanks, applied!

Kind regards
Uffe
