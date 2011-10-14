From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Fri, 14 Oct 2011 13:03:27 -0600
Message-ID: <CACxGe6v=NuxX3b=7wG6hMZjO22_zEg3Q4LtjT3UPtv2bKFtjWQ@mail.gmail.com>
References: <CACxGe6vF6em0-PnJ7UuH0CQ0_StJTfmFKBsktvb9O+ccCx6E8A@mail.gmail.com>
	<Pine.LNX.4.44L0.1110141229450.2036-100000@iolanthe.rowland.org>
	<CACxGe6t2Xu5B0AKZJe-6HEpxK6GfuNm0Y2Kb_bs8ZwaTz5XnRg@mail.gmail.com>
	<4E9885CF.1000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E9885CF.1000301@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-omap@vger.kernel.org, Greg KH <greg@kroah.com>, Linux PM List <linux-pm@vger.kernel.org>, Ming Lei <tom.leiming@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Andrei Warkentin <awarkentin@vmware.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, Manjunath@jasper.es, Dilan Lee <dilee@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 14, 2011 at 12:56 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 10/14/2011 10:20 AM, Grant Likely wrote:
>>
>> On Fri, Oct 14, 2011 at 10:33 AM, Alan Stern<stern@rowland.harvard.edu>
>> =A0wrote:
>>>
>>> On Fri, 14 Oct 2011, Grant Likely wrote:
>>>
>>>>> How can a device acquire children before it has a driver?
>>>>
>>>> There are a few potential situations in embedded systems (or at least
>>>> nothing currently prevents it) where platform setup code constructs a
>>>> device hierarchy without the aid of device drivers, and it is still
>>>> possible for a parent device to be attached to a driver. =A0IIUC, SPARC
>>>> creates an entire hierarchy of platform_devices from all the nodes in
>>>> the OpenFirmware device tree, and any of those devices can be bound to
>>>> a driver. =A0I don't like that approach, but at the very least it needs
>>>> to be guarded against.
>>>
>>> Do these devices ever require deferred probes?
>>
>> Yes, they very well might. =A0However, I'm happy with the limitation
>> that only leaf devices can take advantage of probe deferral.
>>
>
>
> I have:
>
> I2C-Bus-A
> =A0+--Mux-I2C (controlled by parent I2C-Bus-A)
> =A0 =A0 =A0+---I2C-Bus-1
> =A0 =A0 =A0| =A0 =A0 =A0+--GPIO-Expander-A
> =A0 =A0 =A0|
> =A0 =A0 =A0+---I2C-Bus-2
> =A0 =A0 =A0 =A0 =A0 =A0 +--GPIO-Expander-B
>
> These all have a parent/child relationship so no deferral is needed, so f=
ar
> so good.
>
>
> Then this:
>
> MDIO-Bus-A
> =A0 +---Mux-MDIO (controlled by GPIO-Expander-A)
> =A0 =A0 =A0 =A0 +---MDIO-Bus-1
> =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0 +---MDIO-Bus-2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 +---PHY-1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 +---PHY-2
>
> In this case the driver for Mux-MDIO needs to be deferred until *both*
> MDIO-Bus-A's driver *and* GPIO-Expander-B's driver are loaded. =A0A perfe=
ct
> use case for the patch.
>
> Would you consider Mux-MDIO to be a 'leaf device'? =A0If not, then I have=
 real
> problems with 'the limitation that only leaf devices can take advantage of
> probe deferral'

leaf device **at the time of its driver probe**.  :-)  After the
device has all of its dependencies met, it can freely add child
devices.  In your case, the child devices will get added by the
Mux-MDIO device driver, so all is good.

g.
