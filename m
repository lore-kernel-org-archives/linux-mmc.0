From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/7] mmc: dw_mmc: add device tree support
Date: Sat, 12 May 2012 14:13:07 +0530
Message-ID: <CAJuYYwTQ6M0uTLQ_1M9HdcBpaYd2vws36Xx0fJFmwfJ-LSVJAA@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
 <CAJuYYwSmiPNrFhd9xr2AkAbRfJm_gP9ym+AXyy9jyPG3FnFuhA@mail.gmail.com>
 <CAOesGMiXfODM=hDp9EP3uQOk041XCvPFfTzDwfkvBWeGWLdCgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAOesGMiXfODM=hDp9EP3uQOk041XCvPFfTzDwfkvBWeGWLdCgg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 12 May 2012 12:37, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
> Hi,
>
> On Thu, May 10, 2012 at 3:15 AM, Thomas Abraham
> <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Hi Olof,
>>
>> On 2 May 2012 23:37, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
>>> Hi,
>>
>> [...]
>>
>>>> +# Slots: The slot specific information are contained within child-nod=
es with
>>>> + =A0each child-node representing a supported slot. There should be at=
least one
>>>> + =A0child node representing a card slot. The name of the slot child n=
ode should
>>>> + =A0be 'slot{n}' where n is the unique number of the slot connnected =
to the
>>>> + =A0controller. The following are optional properties which can be in=
cluded in
>>>> + =A0the slot child node.
>>>
>>> Since we're talking slots / cards on a bus, I think the addressing
>>> model would be useful here. So in the main controller node:
>>> =A0 =A0#address-cells =3D <1>;
>>> =A0 =A0#size-cells =3D <0>;
>>>
>>> And then each slot would need a reg property and possibly unit address:
>>>
>>> =A0 slot {
>>> =A0 =A0 =A0 =A0reg =3D <0>;
>>> =A0 =A0 =A0 =A0...
>>> =A0 };
>>>
>>> (unit addresses on the slots are only needed if they can't be
>>> disambiguated by name, so not needed if you only have one slot).
>>>
>>
>> Is the addressing model as described above needed in this case? The
>> address for a slot is not used by the controller driver code and is
>> just a virtual number. It would be sufficient to represent the nodes
>> representing the slots with a unique name.
>
> The driver has the concept of slot IDs (slot->id struct member), and
> the hardware definitely enumerates them.
>
> So, I think it makes sense to give a chance to enumerate the slots in
> the device tree. Otherwise, how do you know which one is which on
> hardware? It also opens up the flexibility to have the same name for
> both slots if it makes sense to describe a board that way.

Thanks Olof. Yes, I missed the usage of the id number in the driver. I
will add the slot addressing as you have suggested and repost.

Thanks,
Thomas.

>
>
> -Olof
