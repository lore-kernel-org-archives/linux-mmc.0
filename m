From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 3/5] mmc: tegra: implement UHS tuning
Date: Tue, 29 Mar 2016 18:12:39 +0100
Message-ID: <56FAB787.7030407@nvidia.com>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
 <1450809664-11360-4-git-send-email-dev@lynxeye.de>
 <56FAAF59.8080501@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FAAF59.8080501-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


On 29/03/16 17:37, Jon Hunter wrote:
> Hi Lucas,
>=20
> On 22/12/15 18:41, Lucas Stach wrote:
>> This implements the UHS tuning sequence in a similar way to the one
>> contained in the TRM. It deviates in the way how to check if the tap
>> value is passing, by using the common Linux MMC function, which does
>> not only check for data CRC errors, but also if the received block
>> pattern is correct.
>>
>> Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
>=20
> I have been investigating a hang that occurs randomly during
> system-suspend on Tegra124 Jetson TK1 (I have also reproduced the
> problem on Tegra124 Nyan Big as well) with -next. The problem does no=
t
> occur on every suspend transition but if I execute 100 transitions I
> will typically see it at some point. For example ...
>=20
> count=3D0; while [ $count -lt 100 ]; do rtcwake -d rtc0 -m mem -s 3; =
echo
> Suspend iteration $count; count=3D`expr $count + 1`; done
>=20
> I was able to bisect this problem down to RMK's commit 71fcbda0fcdd
> (=93mmc: sdhci: fix command response CRC error handling=94). However,
> looking at RMK's change, I believe that this commit is not the proble=
m
> but has exposed a problem with the tegra SDHCI driver.
>=20
> When the hang occurs I always see the following when starting the
> suspend sequence and after which the system continues to suspend but
> never exits suspend:
>=20
> 	mmc0: Timeout waiting for hardware interrupt.
>=20
> The above message is a symptom of RMK's commit and I have found that
> when I see this, it always occurs during tegra_sdhci_execute_tuning()
> because sometimes we get a CRC error.

=46or completeness, when disabling the UHS modes for Tegra, I no longer
see the hang during suspend (because the execute_tuning() is not called=
).

Cheers
Jon
