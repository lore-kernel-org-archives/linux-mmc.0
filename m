From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider in
 host controller
Date: Thu, 30 Sep 2010 15:00:25 +0900
Message-ID: <AANLkTi=r0x-ciYG7JVyidgan12JUKmVRhNjNCR_uSfFf@mail.gmail.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
	<AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
	<20100917155928.GA7561@void.printf.net>
	<AANLkTimyvrSxQiF4A4pbmK8nME2ko9MRtqvcuMrY2rKR@mail.gmail.com>
	<20100930015154.GA1269@void.printf.net>
	<000a01cb6061$f9fc3220$edf49660$%seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000a01cb6061$f9fc3220$edf49660$%seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jeongbae Seo <jeongbae.seo@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, ??? <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 30, 2010 at 2:40 PM, Jeongbae Seo <jeongbae.seo@samsung.com=
> wrote:
> Chris wrote:
>
>> Hi Kyungmin, Ben,
>>
>> On Thu, Sep 30, 2010 at 10:18:12AM +0900, Kyungmin Park wrote:
>> > On Sat, Sep 18, 2010 at 12:59 AM, Chris Ball <cjb@laptop.org> wrot=
e:
>> > > Hi,
>> > >
>> > > On Thu, Sep 16, 2010 at 06:08:28PM +0900, Kyungmin Park wrote:
>> > >> Well there are two implementations. and no conclusion yet.
>> > >> as s5pc210 don't support internal SDHCI clock, DMC overrides th=
e
>> > >> function operation itself when s5pc210. System LSI use the quir=
ks.
>> > >>
>> > >> Choose any one from MMC maintainer.
>> > >
>> > > Both approaches are generally acceptable for MMC, so I would wan=
t to
>> > > leave it up to the maintainer of the driver in question (which i=
s Ben,
>> > > in this case?) to choose between them.
>> >
>> > Hi Chris,
>> >
>> > Did you get the opinion from Ben?
>> >
>> > I hope this decision will be done before 2.6.37 merge windows star=
t to
>> > support SDHCI support on s5pc210.
>>
>> Hm, I didn't, and Ben's been silent about the urgent sdhci-s3c patch=
es
>> too. =A0Ben, are you just dealing with a large backlog, or are you
>> interested in nominating someone else to take over sdhci-s3c?
>
> Hi Chris, Kyungmin
>
> I'd like to let you know that Ben had reviewed and commented for
> "[PATCH v2 2/2] sdhci-s3c: Add support no internal clock divider" in =
host
> controller in 9/21. However, our response was late due to our holiday=
s. I
> made a response in 9/28 that why we use this quirk and now we're wait=
ing for
> his opinion.
>
> Kyungmin, did you check Ben's review comments for this ? When I saw i=
t, his
> approach is just a bit different from you and me. Please let us know =
if you
> have any idea about his comments.

I think he just ask "why these quirk are needed" and you already
explained it. I don't have any clue this approach.
Anyway he suggest any ideas I will check it. but no comments then no wa=
y.

Thank you,
Kyungmin Park
>
> Thanks,
> Best Regards
> Jeongbae Seo
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
