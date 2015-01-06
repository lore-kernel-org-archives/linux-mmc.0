From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date: Tue, 06 Jan 2015 11:45:58 +0100
Message-ID: <54ABBCE6.8060904@metafoo.de>
References: <22569458.nE7JkNNnz3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22569458.nE7JkNNnz3@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-mmc@vger.kernel.org

On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
> As discussed on the topic of shmobile DMA today, jz4740 is the only
> user of the slave_id field in dma_slave_config besides shmobile. This
> use is really incompatible with the way that other drivers use the
> dmaengine API, so we should get rid of it.

Do you have a link to that discussion?

>
> This adds a trivial filter function that uses the filter param to
> pass the dma type, and uses that in both drivers.

In my opinion that's just from bad to worse. Using filter functions isn't 
that great in the first place. And using them to pass data from the consumer 
to the DMA provider is just a horrible abuse of the API.

The patch also adds a platform dependency, so the drivers won't built with 
COMPILE_TEST anymore.

- Lars
