From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Tue, 11 Oct 2011 20:29:18 +0800
Message-ID: <CACVXFVMnt-ChUDhawhoyMm-wJ8xSQAWs1c8ykzmyshfX49HEsw@mail.gmail.com>
References: <20111008155502.GB616@kroah.com>
	<361419345.198335.1318268242916.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <361419345.198335.1318268242916.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Grant Likely <grant.likely@secretlab.ca>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 11, 2011 at 1:37 AM, Andrei Warkentin <awarkentin@vmware.com> wrote:
> Hi,
>
> ----- Original Message -----
>> From: "Greg KH" <greg@kroah.com>
>> To: "Josh Triplett" <josh@joshtriplett.org>
>> Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, "Grant Likely"
>> <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
>> "Dilan Lee" <dilee@nvidia.com>, "Mark Brown" <broonie@opensource.wolfsonmicro.com>, Manjunath@jasper.es
>> Sent: Saturday, October 8, 2011 11:55:02 AM
>> Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
>>
>
> I'm a bit of a fly on the wall here, but I'm curious how this impacts suspend/resume.
> device_initialize->device_pm_init are called from device_register, so certainly this
> patch doesn't also ensure that the PM ordering matches probe ordering, which is bound
> to break suspend, right? Was this ever tested with the OMAP target? Shouldn't the

Inside device_add(), device_pm_add is called before bus_probe_device,
so the patch can't change the device order in pm list, and just change
the driver probe order.

> PM change be also part of this patch set? I don't see why you would want to have this in
> without the PM changes.
>


thanks,
-- 
Ming Lei
