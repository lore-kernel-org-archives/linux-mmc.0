From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 10/11] soc: ti: knav_qmss_queue: use
 of_property_read_bool
Date: Fri, 5 Aug 2016 14:59:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1608051456170.2999@hadrien>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr> <1470387411-15879-11-git-send-email-Julia.Lawall@lip6.fr> <c010a500-87ce-19ad-0109-f57eba3c6981@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c010a500-87ce-19ad-0109-f57eba3c6981@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-mmc@vger.kernel.org



On Fri, 5 Aug 2016, Robin Murphy wrote:

> Hi Julia,
>
> On 05/08/16 09:56, Julia Lawall wrote:
> > Use of_property_read_bool to check for the existence of a property.
>
> This caught my eye since Rob told me off for doing the same recently[1].
>
> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @@
> > expression e1,e2;
> > statement S2,S1;
> > @@
> > -       if (of_get_property(e1,e2,NULL))
> > +       if (of_property_read_bool(e1,e2))
> >         S1 else S2
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> >  drivers/soc/ti/knav_qmss_queue.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> > index b73e353..56b5d7c 100644
> > --- a/drivers/soc/ti/knav_qmss_queue.c
> > +++ b/drivers/soc/ti/knav_qmss_queue.c
> > @@ -1240,7 +1240,7 @@ static int knav_setup_queue_range(struct knav_device *kdev,
> >  	if (of_get_property(node, "qalloc-by-id", NULL))
>
> According to the binding, "qalloc-by-id" _is_ a boolean property, so
> this one really does deserve to be of_property_read_bool()...
>
> >  		range->flags |= RANGE_RESERVED;
> >
> > -	if (of_get_property(node, "accumulator", NULL)) {
> > +	if (of_property_read_bool(node, "accumulator")) {
>
> ...whereas "accumulator" must have a value, so this isn't technically
> appropriate. In general, most of these "if the property exists, read the
> property and do stuff" checks are probably a sign of code that could be
> simplified by refactoring the "do stuff" step to just specifically
> handle the "read the property" step returning -EINVAL when it's not present.

Thanks for the very helpful feedback.  I will rethink the patch set in
light of this information.

julia

> Robin.
>
> [1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg13375.html
>
> >  		ret = knav_init_acc_range(kdev, node, range);
> >  		if (ret < 0) {
> >  			devm_kfree(dev, range);
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
