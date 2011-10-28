From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Fri, 28 Oct 2011 12:24:41 +0530
Message-ID: <CAGxe1ZExwe9rmKcEpj=s4ixK7jdrGE=us-7Kax9HY1917PC9fg@mail.gmail.com>
References: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2sjmf4jis.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2sjmf4jis.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27 October 2011 01:23, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish,
>
> On Wed, Oct 26 2011, Girish K S wrote:
>> This patch adds the support of the HS200 bus speed for eMMC 4.5 devi=
ces.
>> The eMMC 4.5 devices have support for 200MHz bus speed.The mmc core =
and
>> host modules have been touched to add support for this module.
>>
>> It is necessary to know the card type in the sdhci.c file to add sup=
port
>> for eMMC tuning function. So card.h file is included to import the c=
ard
>> data structure.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>
> The long case statements and conditionals in this patch make it prett=
y
> dense/ugly -- can you think of a way to avoid doing this to the code?
Definitely will workout.
> Also, it would be good to hear if anyone else has tested/is using thi=
s
> patch.
>
> Is having a new mmc_card_hs200() test desirable, compared to just
> reusing mmc_card_highspeed() and checking the ext_csd.card_type?
The specification classifies from 26 to 52MHz as high speed. And
anything above it upto 200 as hs200. I added the macro for
clarity and to be inclined to the specification.
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
