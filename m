From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 02/13] dmaengine: Introduce dma_request_slave_channel_compat_reason()
Date: Wed, 18 Nov 2015 18:00:41 +0200
Message-ID: <CAHp75Ve+n0PhOJKu+=y9_zuqC1rSBTdBSjHAdu6BKK0FzDmE0A@mail.gmail.com>
References: <1432646768-12532-1-git-send-email-peter.ujfalusi@ti.com>
	<6358656.jIv3GGCCXu@wuerfel>
	<CAHp75VeZFXp9i_zz7CBkVQVPGQxuzYk9AbWbbbn33r8YX3LCdw@mail.gmail.com>
	<8215351.e99Q2vhQ5T@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <8215351.e99Q2vhQ5T@wuerfel>
Sender: linux-crypto-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, dmaengine <dmaengine@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 18, 2015 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 18 November 2015 17:43:04 Andy Shevchenko wrote:
>> >
>> > I assume that the sst-firmware.c case is a mistake, it should just=
 use a
>> > plain DMA_SLAVE and not DMA_MEMCPY.
>>
>> Other way around.
>>
>
> Ok, I see. In that case I guess it also shouldn't call
> dmaengine_slave_config(), right? I don't think that's valid
> on a MEMCPY channel.

Hmm=E2=80=A6 That's right, though I suspect still one thing why it's do=
ne this
way. Let's ask Vinod and Liam about that.

--=20
With Best Regards,
Andy Shevchenko
