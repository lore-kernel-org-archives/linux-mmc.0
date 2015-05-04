From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: cast to avoid unexpected error
Date: Mon, 4 May 2015 12:43:15 +0200
Message-ID: <CAPDyKFqd=nUStFwO6BAAKT=b4gVXV_YHmf3jZxOtZ7CH3iHPLg@mail.gmail.com>
References: <redmine.issue-68414.20150330134838@dm.renesas.com>
	<redmine.journal-531718.20150406210913@dm.renesas.com>
	<87wq1n5bht.wl%kuninori.morimoto.gx@renesas.com>
	<87sic3bbhd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sic3bbhd.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: ryusuke.sakato.bx@renesas.com, yoshihiro.shimoda.uh@renesas.com, hiroyuki.yokoyama.vx@renesas.com, takeshi.kihara.df@renesas.com, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 April 2015 at 06:06, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Hi Ulf
>
> These are non RFC version of mmc data cast patches
> which were posted in
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Please run another round of checkpatch for these.

Kind regards
Uffe
