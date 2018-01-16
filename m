From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/14] mmc: mmci: Add STM32 variant
Date: Tue, 16 Jan 2018 08:38:33 +0100
Message-ID: <CACRpkdY88umqVBcFNy7Z6vgHztRr7MbAjh-AWz0nYgFXoOwCLQ@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-5-git-send-email-patrice.chotard@st.com>
 <CACRpkdYVDpmEmrF=Zk1zX8RCRnPDieTgPuCen6KQ4ttFpAm+Yg@mail.gmail.com> <ce14077b-2b8b-f8a7-2107-78b1d9dcab27@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ce14077b-2b8b-f8a7-2107-78b1d9dcab27-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 15, 2018 at 6:17 PM, Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org> wrote:

>>> +       {
>>> +               .id     = 0x00880180,
>>> +               .mask   = 0x00ffffff,
>>> +               .data   = &variant_stm32,
>>> +       },
>>
>> Since ux500 was 480180 I wonder what variants 5,6,7 are...
>
> What is the rule to define the id ?

These four bits mean "revision".

The number comes from hardware, so the ST ASIC department
has some person who is responsible for revising the VHDL or
Verilog code that this hardware is compiled from, and that person
is bumping the version.

Theoretically it is a "company function" or something bureaucratic
like that updating the hardware so I guess it could be several
people following procedure who have updated this number in the
hardware over the years.

But I bet it is a single person in Grenoble who has been doing
the MMC/SD block since it appeared.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
