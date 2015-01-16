From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] mmc: card: Add eMMC command queuing support in mmc
 block layer
Date: Fri, 16 Jan 2015 09:26:36 +0100
Message-ID: <CAPDyKFqSJAqi0t0_oQwRMZPaZRVUVJHWhmayoaN3UC8CdL+3aQ@mail.gmail.com>
References: <20141202115821.GA27658@asutoshd-ics.in.qualcomm.com>
	<CAPDyKFr+os_1zN=RRM2tGJhH89ULf6ZK5YgOGkFtgiO=oT5cPg@mail.gmail.com>
	<54B8895C.5070500@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <54B8895C.5070500@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>
>> Also, please don't forget to provide some perfomance numbers.
>
> I can provide some performance numbers in the last week of february or in
> the beginning of March. Is that fine ?
> Do you want the comments addressed before I publish the performance numbers
> or do you prefer the comments to be addressed first ?
>

I fine with iterating this patchset a few more times without having
available performance numbers. So please go ahead and address my
comments.

BTW, I have recently queued below patch, which enables the
asynchronous request mechanism for sdhci. I expect you to use it while
comparing performance numbers later on.
mmc: sdhci: use pipeline mmc requests to improve performance

Kind regards
Uffe
