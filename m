From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
Date: Mon, 29 Apr 2019 12:12:46 -0700
Message-ID: <7hwojcr5g1.fsf@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com> <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCBGU53h9063jj8n8q3whT=eZ9y6MPaYYqU_K9UXssK_nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Ulf, Hi Kevin,
>
> On Mon, Apr 29, 2019 at 12:45 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> >
>> > The purpose of this series is too improve reliability of the amlogic mmc
>> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
>> >
>> > * The 3 first patches are just harmless clean ups.
>>
>> Applied these first three, postponing the the rest until Martin are
>> happy with all of them. Thanks!
> thank you for taking the first three patches!
> I am fine with everything except the patch description of patch 4 and
> 7 as noted here: [0]
>
> Kevin, can you please also have a look at this series (if you didn't already)?
> you reviewed earlier changes to the tuning mechanism in this driver.
> it would be great to know that you're happy with these changes as well.

I've reviewed the series, and am happy with it as is, including the
changelogs as is.

Ulf, for the series, feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
