From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 00/20] native support for wl1271 on ZOOM
Date: Fri, 23 Jul 2010 02:56:07 +0300
Message-ID: <AANLkTinQa8-SePaCmqmMMOcTtJOVfKHq0yH4YCRMuqPg@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1007230052320.12562@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1007230052320.12562@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Kalle Valo <kalle.valo@iki.fi>, Pandita Vikram <vikram.pandita@ti.com>, linux@arm.linux.org.uk, Roger Quadros <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, linux-omap@vger.kernel.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 23, 2010 at 1:56 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 21 Jul 2010, Ohad Ben-Cohen wrote:
>
>> This patch series adds native support for wl1271 on ZOOM.
>>
>> Changes since v1:
>>
>> - introduce a fixed regulator device to control the power of wl1271
>> - allow to propagate private board-specific data to SDIO function drivers
>> - allow SDIO function driver to control the card's power via new API
>> - make it possible to keep the card's power down (without depending
>> =A0 on an explicit SDIO function driver power-down request)
>>
>> Thanks to these changes, we no longer need a separate platform
>> device (carrying e.g. the external irq information of the device),
>> and no longer need to emulate virtual card detect events.
>>
>> The two "board muxing" pathces were already taken by Tony, and
>> are resent here just to make it easier for people to use/test these path=
ces.
>>
>> The changes to the MMC core really needs careful review; there still
>> might be some pitfalls that haven't been covered. E.g., one thing
>> we plan to look at next is their bahvior together with SDIO Suspend/Resu=
me.
>>
>> Special thanks to Roger Quadros and Nicolas Pitre for their extensive
>> review and helpful suggestions.
>
> FYI, I do intend to review those patches, but I'll be flying home in a
> couple hours, and once there I'll be gone on vacation for 2 weeks. =A0So
> this review won't happen right away.

Thanks, Nicolas.


>
>
> Nicolas
>
