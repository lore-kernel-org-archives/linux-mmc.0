From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ARM: edma: Split up header file to
 platform_data and API file
Date: Tue, 30 Dec 2014 15:17:17 +0200
Message-ID: <54A2A5DD.2030502@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <1417084891-17990-4-git-send-email-peter.ujfalusi@ti.com>
 <20141208124917.GI16827@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20141208124917.GI16827@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, khilman@deeprootsystems.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, chris@printf.net, dmaengine@vger.kernel.org, ulf.hansson@linaro.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 12/08/2014 02:49 PM, Vinod Koul wrote:
> On Thu, Nov 27, 2014 at 12:41:31PM +0200, Peter Ujfalusi wrote:
>> include/linux/platform_data/ is not a correct place to keep the API
>> definitions for edma, it is meant to be only for the pdata for the devic=
e.
>> Clean up this by moving the API to include/linux/edma.h
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  arch/arm/common/edma.c                     |   3 +-
>>  arch/arm/mach-davinci/devices.c            |   1 +
>>  arch/arm/mach-davinci/include/mach/da8xx.h |   1 +
>>  drivers/dma/edma.c                         |   2 +-
>>  include/linux/edma.h                       | 153 ++++++++++++++++++++++=
+++++++
>>  include/linux/platform_data/edma.h         | 148 ++--------------------=
------
>>  sound/soc/davinci/davinci-pcm.h            |   1 +
>>  7 files changed, 165 insertions(+), 144 deletions(-)
>>  create mode 100644 include/linux/edma.h
> I was hoping that this will have delete for platform_data/edma.h, do we
> still need that and why shouldn't we get rid of this :)

We still need it for the legacy boot of davinci devices. We can boot some
davinci SoC/boards with DT, but not all of them.

-- =

P=E9ter
