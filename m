From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 4/5] mmc: debugfs: add HS400 enhanced strobe
 description
Date: Tue, 24 May 2016 09:52:32 +0800
Message-ID: <c6137b5e-c77e-bb54-cf0a-c23e7714dfb1@rock-chips.com>
References: <1463976789-29618-1-git-send-email-shawn.lin@rock-chips.com>
 <1463976844-29821-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WFQ4aG-LhB=s6KhdoHtAjuQnaW6duyzh1LUKAHdDXvTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WFQ4aG-LhB=s6KhdoHtAjuQnaW6duyzh1LUKAHdDXvTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2016/5/24 4:56, Doug Anderson =E5=86=99=E9=81=93:
> Shawn,
>
> On Sun, May 22, 2016 at 9:14 PM, Shawn Lin <shawn.lin@rock-chips.com>=
 wrote:
>> We introduce HS400 with enhanced strobe function, so we need
>> to add it for debug show.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>  drivers/mmc/core/debugfs.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 9382a57..51d7c38 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -148,7 +148,9 @@ static int mmc_ios_show(struct seq_file *s, void=
 *data)
>>                 str =3D "mmc HS200";
>>                 break;
>>         case MMC_TIMING_MMC_HS400:
>> -               str =3D "mmc HS400";
>> +               mmc_card_hs400es(host->card) ?
>> +                       (str =3D "mmc HS400 enhanced strobe") :
>> +                       (str =3D "mmc HS400");
>
> Not sure it's terribly important, but I've typically seen this as:
>
> str =3D mmc_card_hs400es(host->card) ?
>           "mmc HS400 enhanced strobe" : "mmc HS400";
>
> AKA: don't repeat the "str =3D"
>

Thanks for your review and test. I wanna wait for some more days
to see if there are any other comments for this patchset.


> I doubt it really matters that much, though, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
>
>


--=20
Best Regards
Shawn Lin
