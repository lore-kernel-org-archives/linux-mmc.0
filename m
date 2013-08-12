From: Alban Browaeys <prahal@yahoo.com>
Subject: Re: mmc oops on suspend - remove device
Date: Mon, 12 Aug 2013 15:00:56 +0200
Message-ID: <1376312456.3930.8.camel@penelope>
References: <1376151006.31508.2.camel@penelope>
	 <520889E3.3020303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm2-vm1.bullet.mail.ird.yahoo.com ([77.238.189.200]:47185 "HELO
	nm2-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752713Ab3HLNBA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Aug 2013 09:01:00 -0400
In-Reply-To: <520889E3.3020303@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Le lundi 12 ao=C3=BBt 2013 =C3=A0 16:08 +0900, Jaehoon Chung a =C3=A9cr=
it :
> Hi, Alban.
>=20
> I think that it needs be set to "non-removable" for emmc.
> If emmc is set to removable, it should be removed when entered suspen=
d.
>=20

Indeed I thought so too. But everytime I try to set it as non removable
the emmc is not discovered on boot (this is the boot partition , this i=
s
an emmc factor that "can" be removed but I believe it is not
hotplugable).
Seems the broken-cd in dw-mshc exynos  is bound to a specific quirk
which is required for to get emmc working here.
upstream dts for exynos4412 odroidx and origen (which are closed to
odroid u2) do so too for emmc mshc.

Yesterday I looked anew at attempting to use non-removable without
success . I also did not find a test for non removable in the path from
mmc_pm_notify to mmc_blk_remove (ending up in mmc_blk_remove_req). Did =
I
miss it ?

Best regards
Alban

> Best Regards,
> Jaehoon Chung
>=20
> On 08/11/2013 01:10 AM, Alban Browaeys wrote:
> >=20
> > The oops spots  commit add710e , though I cannot tell if the commit=
 is
> > at fault. That is could card from md->queue.card be null and then c=
hecks
> > are missing before dereference or is the issue that card is null wh=
en it
> > ought not.
> > This happens when I do :
> > # echo "mem" > /sys/power/state
> >=20
> > mmc1 is emmc that can be detached:
> >=20
> > dts (derived from exynos4412-odroidx and exynos4412-origen)
> >         mshc@12550000 {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >                 pinctrl-0 =3D <&sd4_clk &sd4_cmd &sd4_cd &sd4_bus8>=
;
> >                 pinctrl-names =3D "default";
> >                 vmmc-supply =3D <&ldo20_reg &buck8_reg>;
> >                 status =3D "okay";
> >=20
> >                 num-slots =3D <1>;
> >                 supports-highspeed;
> >                 broken-cd;
> >                 fifo-depth =3D <0x80>;
> >                 card-detect-delay =3D <200>;
> >                 samsung,dw-mshc-ciu-div =3D <3>;
> >                 samsung,dw-mshc-sdr-timing =3D <2 3>;
> >                 samsung,dw-mshc-ddr-timing =3D <1 2>;
> >                 samsung,dw-mshc-hwreset-gpio =3D <&gpk1 2 1>;
> >=20
> >                 slot@0 {
> >                         reg =3D <0>;
> >                         bus-width =3D <8>;
> >                 };
> >         };
> >=20
> > ie drivers/mmc/host/dw_mmc-exynos.c
> >=20
> >=20
> > The commit that produce the issue
> > commit add710eaa88606de8ba98a014d37178579e6dbaf
> > Author: Johan Rudholm <johan.rudholm@stericsson.com>
> > Date:   Fri Dec 2 08:51:06 2011 +0100
> >=20
> >     mmc: boot partition ro lock support
> >    =20
> >     Enable boot partitions to be read-only locked until next power =
on
> > via
> >     a sysfs entry. There will be one sysfs entry for each boot
> > partition:
> >    =20
> >     /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
> >    =20
> >     Each boot partition is locked by writing 1 to its file.
> >    =20
> >     Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> >     Signed-off-by: John Beckett <john.beckett@stericsson.com>
> >     Signed-off-by: Chris Ball <cjb@laptop.org>
> >=20
> >=20
> >=20
> > Oops:
> >=20
> > Unable to handle kernel NULL pointer dereference at virtual address=
 000002a8
> > pgd =3D ecd9c000
> > [000002a8] *pgd=3D6d082831, *pte=3D00000000, *ppte=3D00000000
> > Internal error: Oops: 17 [#1] SMP ARM
> > Modules linked in: bnep rfcomm smsc95xx usbnet mii bluetooth nfsd l=
ockd nfs_acl exportfs auth_rpcgss sunrpc oid_registry vfat fat btrfs ra=
id6_pq xor zlib_deflate
> > CPU: 3 PID: 2384 Comm: bash Not tainted 3.11.0-rc4-00869-ga7143f1-d=
irty #60
> > task: c46d9b00 ti: ecefc000 task.ti: ecefc000
> > PC is at mmc_blk_remove_req+0x58/0x88
> > LR is at _raw_spin_unlock_irqrestore+0xc/0x14
> > pc : [<c034e7d8>]    lr : [<c0494ac8>]    psr: 200f0053
> > sp : ecefddf8  ip : 00000000  fp : 000dc1e8
> > r10: c058ead8  r9 : ecce3f18  r8 : 00100100
> > r7 : 00200200  r6 : c26b7118  r5 : 00000000  r4 : c26b1dc0
> > r3 : 00000002  r2 : 00000000  r1 : 200f0053  r0 : 00000000
> > Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment user
> > Control: 10c5387d  Table: 6cd9c04a  DAC: 00000015
> > Process bash (pid: 2384, stack limit =3D 0xecefc240)
> > Stack: (0xecefddf8 to 0xecefe000)
> > dde0:                                                       c26b205=
8 c26b6898
> > de00: c26b6898 c03512d0 d2623180 d2623188 c06bb90c c26b06d8 c26b6e8=
0 c0351308
> > de20: 00000000 c0494ac8 d2623188 c06bbd54 c06bb90c c26b06d8 0000000=
3 c034409c
> > de40: c0344084 c0265a20 c46d9b00 d26231bc d2623188 c0265a88 0000000=
0 d2623188
> > de60: c479aafc c0265410 d2623188 c26b0448 00000001 c0262c04 d262318=
8 c26b0440
> > de80: 00000001 c034463c c26b0440 c0345124 c26b060c c0343fb0 c0343f1=
c fffffffc
> > dea0: c06bb3f8 00000000 00000000 c00413b4 c0690fec ffffffff 0000000=
0 00000003
> > dec0: 00000004 c00417b4 00000000 c0497a70 00000003 00000003 c06c5a6=
0 c0497a70
> > dee0: 00000003 c00417e4 00000000 00000003 c06c5a60 c0059d48 0000000=
0 c005aa9c
> > df00: ed366000 00000003 c0497a70 c0059a68 00000004 ecefdf80 ecce3f0=
0 d27f6d20
> > df20: 00000004 d27f5e80 c04b06b8 c01d610c 00000004 c012b224 ed0ee00=
0 00000004
> > df40: 000af408 ecefdf80 00000000 00000000 00000000 c00d59d4 c460790=
0 00000001
> > df60: 0000000a ed0ee000 00000000 000af408 00000004 00000000 0000000=
0 c00d5d3c
> > df80: 00000000 00000000 00000000 b6e98a78 00000004 000af408 0000000=
4 c000ebc8
> > dfa0: ecefc000 c000ea20 b6e98a78 00000004 00000001 000af408 0000000=
4 00000000
> > dfc0: b6e98a78 00000004 000af408 00000004 be9c596c 000a6094 0000000=
0 000dc1e8
> > dfe0: 00000000 be9c58ec b6e07747 b6e3f11c 40070050 00000001 429a220=
1 8108f000
> > [<c034e7d8>] (mmc_blk_remove_req+0x58/0x88) from [<c03512d0>] (mmc_=
blk_remove_parts.isra.5+0x90/0xa8)
> > [<c03512d0>] (mmc_blk_remove_parts.isra.5+0x90/0xa8) from [<c035130=
8>] (mmc_blk_remove+0x20/0x128)
> > [<c0351308>] (mmc_blk_remove+0x20/0x128) from [<c034409c>] (mmc_bus=
_remove+0x18/0x20)
> > [<c034409c>] (mmc_bus_remove+0x18/0x20) from [<c0265a20>] (__device=
_release_driver+0x7c/0xc8)
> > [<c0265a20>] (__device_release_driver+0x7c/0xc8) from [<c0265a88>] =
(device_release_driver+0x1c/0x28)
> > [<c0265a88>] (device_release_driver+0x1c/0x28) from [<c0265410>] (b=
us_remove_device+0x100/0x11c)
> > [<c0265410>] (bus_remove_device+0x100/0x11c) from [<c0262c04>] (dev=
ice_del+0x110/0x174)
> > [<c0262c04>] (device_del+0x110/0x174) from [<c034463c>] (mmc_remove=
_card+0x64/0x78)
> >=20
> > [<c034463c>] (mmc_remove_card+0x64/0x78) from [<c0345124>] (mmc_rem=
ove+0x24/0x30)
> >=20
> > [<c0345124>] (mmc_remove+0x24/0x30) from [<c0343fb0>] (mmc_pm_notif=
y+0x94/0xf8)
> > [<c0343fb0>] (mmc_pm_notify+0x94/0xf8) from [<c00413b4>] (notifier_=
call_chain+0x44/0x84)
> > [<c00413b4>] (notifier_call_chain+0x44/0x84) from [<c00417b4>] (__b=
locking_notifier_call_chain+0x48/0x60)
> > [<c00417b4>] (__blocking_notifier_call_chain+0x48/0x60) from [<c004=
17e4>] (blocking_notifier_call_chain+0x18/0x20)
> > [<c00417e4>] (blocking_notifier_call_chain+0x18/0x20) from [<c0059d=
48>] (pm_notifier_call_chain+0x14/0x2c)
> > [<c0059d48>] (pm_notifier_call_chain+0x14/0x2c) from [<c005aa9c>] (=
pm_suspend+0xac/0x24c)
> > [<c005aa9c>] (pm_suspend+0xac/0x24c) from [<c0059a68>] (state_store=
+0xb0/0xc4)
> > [<c0059a68>] (state_store+0xb0/0xc4) from [<c01d610c>] (kobj_attr_s=
tore+0x14/0x20)
> > [<c01d610c>] (kobj_attr_store+0x14/0x20) from [<c012b224>] (sysfs_w=
rite_file+0x118/0x164)
> > [<c012b224>] (sysfs_write_file+0x118/0x164) from [<c00d59d4>] (vfs_=
write+0xd8/0x178)
> > [<c00d59d4>] (vfs_write+0xd8/0x178) from [<c00d5d3c>] (SyS_write+0x=
40/0x68)
> > [<c00d5d3c>] (SyS_write+0x40/0x68) from [<c000ea20>] (ret_fast_sysc=
all+0x0/0x30)
> > Code: ebfc509b e59432dc e3130002 0a000006 (e5d532a8)=20
> >=20
> >=20
> > decodecode:
> > Code: ebfc509b e59432dc e3130002 0a000006 (e5d532a8)
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   ebfc509b        bl      0xfff14274
> >    4:   e59432dc        ldr     r3, [r4, #732]  ; 0x2dc
> >    8:   e3130002        tst     r3, #2
> >    c:   0a000006        beq     0x2c
> >   10:*  e5d532a8        ldrb    r3, [r5, #680]  ; 0x2a8         <--=
 trapping instruction
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   e5d532a8        ldrb    r3, [r5, #680]  ; 0x2a8
> >=20
> > from objdump -S:
> > static void mmc_blk_remove_req(struct mmc_blk_data *md)
> > {
> > c034e780:       e92d4038        push    {r3, r4, r5, lr}
> >         struct mmc_card *card;
> >=20
> >         if (md) {
> > c034e784:       e2504000        subs    r4, r0, #0
> > c034e788:       08bd8038        popeq   {r3, r4, r5, pc}
> >                 /*
> >                  * Flush remaining requests and free queues. It
> >                  * is freeing the queue that stops new requests
> >                  * from being accepted.
> >                  */
> >                 mmc_cleanup_queue(&md->queue);
> > c034e78c:       e2845014        add     r5, r4, #20
> > c034e790:       e1a00005        mov     r0, r5
> > c034e794:       eb000e2b        bl      c0352048 <mmc_cleanup_queue=
>
> >                 if (md->flags & MMC_BLK_PACKED_CMD)
> > c034e798:       e59432a0        ldr     r3, [r4, #672]  ; 0x2a0
> > c034e79c:       e3130004        tst     r3, #4
> > c034e7a0:       0a000001        beq     c034e7ac <mmc_blk_remove_re=
q+0x2c>
> >                         mmc_packed_clean(&md->queue);
> > c034e7a4:       e1a00005        mov     r0, r5
> > c034e7a8:       eb000df6        bl      c0351f88 <mmc_packed_clean>
> >                 card =3D md->queue.card;
> >                 if (md->disk->flags & GENHD_FL_UP) {
> > c034e7ac:       e5940010        ldr     r0, [r4, #16]
> >                  * from being accepted.
> >                  */
> >                 mmc_cleanup_queue(&md->queue);
> >                 if (md->flags & MMC_BLK_PACKED_CMD)
> >                         mmc_packed_clean(&md->queue);
> >                 card =3D md->queue.card;
> > c034e7b0:       e5945014        ldr     r5, [r4, #20]
> >                 if (md->disk->flags & GENHD_FL_UP) {
> > c034e7b4:       e5903244        ldr     r3, [r0, #580]  ; 0x244
> > c034e7b8:       e3130010        tst     r3, #16
> > c034e7bc:       0a00000e        beq     c034e7fc <mmc_blk_remove_re=
q+0x7c>
> >                         device_remove_file(disk_to_dev(md->disk), &=
md->force_ro);
> > c034e7c0:       e2800068        add     r0, r0, #104    ; 0x68
> > c034e7c4:       e2841faf        add     r1, r4, #700    ; 0x2bc
> > c034e7c8:       ebfc509b        bl      c0262a3c <device_remove_fil=
e>
> >                         if ((md->area_type & MMC_BLK_DATA_AREA_BOOT=
) &&
> > c034e7cc:       e59432dc        ldr     r3, [r4, #732]  ; 0x2dc
> > c034e7d0:       e3130002        tst     r3, #2
> > c034e7d4:       0a000006        beq     c034e7f4 <mmc_blk_remove_re=
q+0x74>
> > c034e7d8:       e5d532a8        ldrb    r3, [r5, #680]  ; 0x2a8
> > c034e7dc:       e3530000        cmp     r3, #0
> > c034e7e0:       0a000003        beq     c034e7f4 <mmc_blk_remove_re=
q+0x74>
> >                                         card->ext_csd.boot_ro_locka=
ble)
> >                                 device_remove_file(disk_to_dev(md->=
disk),
> > c034e7e4:       e5940010        ldr     r0, [r4, #16]
> >=20
> >=20
> > that is r5 is "card =3D md->queue.card;" and is null, then on
> >  card->ext_csd.boot_ro_lockable oops ensue.
> >=20
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
>=20
> !DSPAM:52088ab925158742279236!
>=20


