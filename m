From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v12 0/9] Cavium MMC driver
Date: Wed, 15 Mar 2017 17:20:21 +0100
Message-ID: <20170315162020.GC5728@hardcore>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <CAK8P3a2ykTOm72B-0maHZ7hq0w2+P=sCBJadekU6TZ4wBHN75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ykTOm72B-0maHZ7hq0w2+P=sCBJadekU6TZ4wBHN75g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 15, 2017 at 04:57:37PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 10, 2017 at 2:24 PM, Jan Glauber <jglauber@cavium.com> wrote:
> > Hi Ulf,
> >
> > I've not heard back from you regarding the bitfields so I assume this
> > means you're insisting on that point. I'd really like to make some
> > progress with this series, so I'm reposting now. All comments should be
> > addressed. Patches are on top of 4.11-rc1.
> >
> > @Rob: I kept your ACK after the removal of the duplicate voltage line,
> > please let me know if that is not OK.
> >
> > Changes to v11:
> > - Fix build error and kill IS_ENABLED() by using an offset per arch
> 
> I've looked at the whole series again and didn't find anything that seemed
> wrong any more, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

Just to note, I think I forgot one thing Ulf wanted, the replacement of
mmc_of_parse_voltage() with a hardcoded value for the Octeon boards.

--Jan
