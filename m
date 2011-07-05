From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3] mmc: documentation of mmc non-blocking request usage
 and design.
Date: Tue, 5 Jul 2011 23:31:53 +0200
Message-ID: <CAJ0pr18MS-zA8xcjE90YQPaG1aUGJZAh_ZFAzhpguPSF-f5sKw@mail.gmail.com>
References: <1309895008-2587-1-git-send-email-per.forlin@linaro.org>
	<1309895008-2587-2-git-send-email-per.forlin@linaro.org>
	<20110705132706.f610abb0.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20110705132706.f610abb0.rdunlap@xenotime.net>
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 5 July 2011 22:27, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Tue, =A05 Jul 2011 21:43:28 +0200 Per Forlin wrote:
>
>> Documentation about the background and the design of mmc non-blockin=
g.
>> Host driver guidelines to minimize request preparation overhead.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>
> It would be better to omit the introductory email and put all of its =
comments
> in this one [PATCH] email.
>
I agree. I'll put the changelog after "--" to exclude it from the
commit message.
All of your comments will be updated in v4.

Thanks for your comments,
Per
