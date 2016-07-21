From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: Unsynchronized access to spi bus by mmc_rescan?
Date: Thu, 21 Jul 2016 17:40:15 -0400
Message-ID: <20160721214015.GG15995@brightrain.aerifal.cx>
References: <20160422212842.GB21636@brightrain.aerifal.cx>
 <20160504224445.GW21636@brightrain.aerifal.cx>
 <20160721204451.GE15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160721204451.GE15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Fleming <matt-HNK1S37rvNbeXh+fF434Mdi2O/JbrIOy@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 21, 2016 at 04:44:51PM -0400, Rich Felker wrote:
> On Wed, May 04, 2016 at 06:44:45PM -0400, Rich Felker wrote:
> > Ping.
> > 
> > On Fri, Apr 22, 2016 at 05:28:42PM -0400, Rich Felker wrote:
> > > I'm working on a driver for the J-core (http://j-core.org) SPI master,
> > > which is currently limited to PIO and using the spi-bitbang framework
> > > (probably not the right thing to use, but planned to change, and seems
> > > orthogonal to the issue at hand). We're using it to access an SD card
> > > via the mmc_spi mmc host driver, and experiencing crashes/corruption
> > > that I tracked down to mmc_rescan (we don't yet have an interrupt for
> > > media change) happening during SPI message transfers. Which locks are
> > > supposed to preclude this from happening? Is it likely something wrong
> > > our driver is using, or is there possibly a general bug in the MMC/SPI
> > > subsystem(s)?
> 
> Ping. I'm also experiencing this issue with multiple devices on the
> same spi bus; access seems completely unsynchronized. While it's hard
> to rule out the possibility of it being specific to the spi master
> driver, the driver just implements transfer_one and set_cs, so
> synchronization would necessarily have to happen at a higher level.
> Any tips on how I could further track down the cause?

OK, I've been reading the code again, and unless I'm mistaken it's
utter nonsense.

The spi master device has a "bus lock flag" that's used in lieu of a
recursive mutex, but it seems to be used entirely incorrectly. The
logic I'm seeing in spi.c is essentially:

	if (some_task_has_spi_bus_locked)
		use_spi_master_without_locking();

There seems to be no check that the task that's using the master
without locking is the same one that locked it!

The relevant code in spi.c is in __pump_messages, where locking is

	if (!bus_locked)
		mutex_lock(&master->bus_lock_mutex);

bus_locked was provided by the caller from master->bus_lock_flag.

Also, master->bus_lock_flag is modified completely unsynchonized from
read access to master->bus_lock_flag. There is no locking of
master->bus_lock_mutex or master->bus_lock_spinlock around the read
accesses to master->bus_lock_flag, and in one place the write (of 0)
to master->bus_lock_flag takes place without holding the spinlock.

The obvious fix would be using an actual recursive mutex to obtain
recursive mutex semantics.

I've Cc'd everybody who appears to have been involved in the original
addition of the spi bus lock infrastructure and subsequent changes to
it.

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
