From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Fri, 7 Oct 2011 15:28:14 -0600
Message-ID: <CACxGe6v_QC4v7omN_bMJi1=46Ww+EdLJ7OiAwpWLWYM6v_cqBQ@mail.gmail.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
 <1317963790-29426-3-git-send-email-manjugk@ti.com> <20111007064928.GE27508@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111007064928.GE27508@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 7, 2011 at 12:49 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 07, 2011 at 10:33:07AM +0500, G, Manjunath Kondaiah wrote=
:
>> +config PROBE_DEFER
>> + =A0 =A0 bool "Deferred Driver Probe"
>> + =A0 =A0 default y
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This option provides deferring driver probe if it has =
dependency on
>> + =A0 =A0 =A0 other driver. Without this feature, initcall ordering =
should be done
>> + =A0 =A0 =A0 manually to resolve driver dependencies. This feature =
completely side
>> + =A0 =A0 =A0 steps the issues by allowing driver registration to oc=
cur in any
>> + =A0 =A0 =A0 order, and any driver can request to be retried after =
a few more other
>> + =A0 =A0 =A0 drivers get probed.
>
> Why is this even an option? =A0Why would you ever want it disabled? =A0=
Why
> does it need to be selected?
>
> If you are going to default something to 'y' then just make it so it
> can't be turned off any other way by just not making it an option at
> all.
>
> It also cleans up this diff a lot, as you really don't want #ifdef in=
 .c
> files.

Okay, we'll drop the kconfig

>> + =A0 =A0 =A0* This bit is tricky. =A0We want to process every devic=
e in the
>> + =A0 =A0 =A0* deferred list, but devices can be removed from the li=
st at any
>> + =A0 =A0 =A0* time while inside this for-each loop. =A0There are tw=
o things that
>> + =A0 =A0 =A0* need to be protected against:
>
> That's what the klist structure is supposed to make easier, why not u=
se
> that here?
>
>> + =A0 =A0 =A0* - if the device is removed from the deferred_probe_li=
st, then we
>> + =A0 =A0 =A0* =A0 loose our place in the loop. =A0Since any device =
can be removed
>> + =A0 =A0 =A0* =A0 asynchronously, list_for_each_entry_safe() wouldn=
't make things
>> + =A0 =A0 =A0* =A0 much better. =A0Simplest solution is to restart w=
alking the list
>> + =A0 =A0 =A0* =A0 whenever the current device gets removed. =A0Not =
the most efficient,
>> + =A0 =A0 =A0* =A0 but is simple to implement and easy to audit for =
correctness.
>> + =A0 =A0 =A0* - if the device is unregistered, and freed, then ther=
e is a risk
>> + =A0 =A0 =A0* =A0 of a null pointer dereference. =A0This code uses =
get/put_device()
>> + =A0 =A0 =A0* =A0 to ensure the device cannot disappear from under =
our feet.
>
> Ick, use a klist, it was created to handle this exact problem in the
> driver core, so to not use it would be wrong, right?

This comment block is stale.  I reworked the code before I handed it
off to Manjunath, but I never rewrote the comment.  The current code
uses a pair of list to keep deferred devices separate from devices
currently being probed, and the problem described above no longer
exists.  However, Manjunath and I will look into switching from the
two list design to using klist.

Thanks for the feedback.
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
