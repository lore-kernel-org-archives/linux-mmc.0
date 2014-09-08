From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/7 v3] mmc: use .multi_io_quirk on sh_mobile
Date: Mon, 8 Sep 2014 12:53:30 +0200
Message-ID: <CAPDyKFqBRX0=ZL9j9L3qu-MEs5yrBH5HBs9nuPbfEw=9TYpO8A@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<8761h578ux.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFqGmVoe91jCpDq5=b4JG6WTJE8TQyZXu7D01DNY=yUi0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqGmVoe91jCpDq5=b4JG6WTJE8TQyZXu7D01DNY=yUi0A@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 September 2014 12:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 September 2014 04:09, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Now, sh_mobile_sdhi can use .multi_io_quirk callback
>> instead of MMC_CAP2_NO_MULTI_READ flags.
>> let's use it.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thanks! Applied for next!

So I understand this one depends on patch 3, putting this on hold,
until we sorted out the comments I had.

Sorry for the noise!

Kind regards
Uffe
