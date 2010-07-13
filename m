From: hardik patel <hk5patel@gmail.com>
Subject: Re: Re: Re: SD Driver : FAT: FAT read failed (blocknr 8) in sd card
	error while removing sd card during writing
Date: Tue, 13 Jul 2010 11:18:17 +0530
Message-ID: <AANLkTinNUYkypPKMqHv4Vbpp5VqtURwYFscswiJJgpeY@mail.gmail.com>
References: <11124329.411231278925125067.JavaMail.weblogic@epml07>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35588 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab0GMFsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2010 01:48:18 -0400
Received: by gxk23 with SMTP id 23so2987122gxk.19
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jul 2010 22:48:18 -0700 (PDT)
In-Reply-To: <11124329.411231278925125067.JavaMail.weblogic@epml07>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: singh.madhav@samsung.com
Cc: Ethan Du <ethan.too@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Madhav,

I have change the card remove sequence as per latest kernel source
2.6.34 .... after changing this i face the same issue.... is there any
way to check card detect status at block layer ? or any other way to
avoid it ....

After removing card .... when i execute any command on board then also
i got below error messages :

=46AT: Directory bread(block 3898) failed
=46AT: Directory bread(block 3899) failed
=46AT: Directory bread(block 3900) failed
=46AT: Directory bread(block 3901) failed
=46AT: Directory bread(block 3902) failed

On Mon, Jul 12, 2010 at 2:28 PM, MADHAV SINGHCHAUHAN
<singh.madhav@samsung.com> wrote:
>
>
>
> I am using 2.6.30 linux kernel version ...
>>>As i told you previously that you need to flush queue as soon as pos=
sible once you remove the card.
> So once you remove card mmc_blk_remove() gets called which calls mmc_=
cleanup_queue() and it further intenally calls
> kthread_stop()(stops thread which process requests).So compare the la=
test kernel version wrt your kernel version
> and you will find the differences in card remove sequence so either y=
ou can backport these functions or change manually
> sequence of these functions.
>
> On Fri, Jul 9, 2010 at 9:20 AM, Madhav Chauhan <madhav.imsec@gmail.co=
m> wrote:
>> On Thu, Jul 8, 2010 at 11:38 PM, hardik patel <hk5patel@gmail.com> w=
rote:
>>> Hi Madhav,
>>>
>>> thanks for your interest... I have card detect register so mmc_get_=
cd
>>> function i can check whether card is inserted or not ... so in sd h=
ost
>>> controller driver can detect that properly... but i think block dri=
ver
>>> does not detect that .... where i have to flush my request queue...=
 i
>>> have gone through block.c and queue.c file which generate mmc_block=
=2Eko
>>> file but not sure where to modify... can any one guide me more
>>
>> Which Kernel version you are using??
>>>
>>>
>>> On Thu, Jul 8, 2010 at 6:35 PM, MADHAV SINGHCHAUHAN
>>> <singh.madhav@samsung.com> wrote:
>>>> Card removal not detected by driver?
>>>> You should see a line of log if card removal is detected:
>>>> card xxxx removed
>>>>
>>>> Would you describe how do you detect card removal/insertion on you=
r board?
>>>>
>>>> Regards,
>>>> -Ethan
>>>>
>>>> On Thu, Jul 8, 2010 at 6:05 PM, hardik patel <hk5patel@gmail.com> =
wrote:
>>>>> I have sd card on board ... During recording/writing SD card, rem=
ove
>>>>> SD card ... then i am getting endless error in dmesg as below :
>>>>>
>>>>> end_request: I/O error, dev mmcblk0, sector 24
>>>>> FAT: FAT read failed (blocknr 8)
>>>>> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
>>>>> sending read/write command, response 0x0, card status 0x0
>>>>> Block mmc_blk_issue_rq function call 346
>>>>> end_request: I/O error, dev mmcblk0, sector 4
>>>>> FAT: FAT read failed (blocknr 4)
>>>>> MMC: killing requests for dead queue
>>>>> end_request: I/O error, dev mmcblk0, sector 8
>>>>> FAT: FAT read failed (blocknr 8)
>>>>> FAT: FAT read failed (blocknr 4)
>>>>> FAT: FAT read failed (blocknr 8)
>>>>> FAT: FAT read failed (blocknr 4)
>>>>> FAT: FAT read failed (blocknr 8)
>>>>> FAT: FAT read failed (blocknr 4)
>>>>> FAT: FAT read failed (blocknr 8)
>>>>>
>>>>> How to stop this message ... what is ideal situation when we remo=
ve
>>>>> card while writing ...... can u help me what to do ?
>>>>>
>>>>>>When we insert the card hot plug dameon start sending the request=
 to block layer =A0and kernel block layer
>>>>>>start sending the request to card.But when you remove the card in=
 between request queue is not flushed properly..
>>>>>>so you need to flush your request queue at appropriate time.Also =
please note that even that you flush your request queue
>>>>>>at appropriate time some messages will come.
>>>>> where is the problem here? sd host controler driver problem or bl=
ock
>>>>> driver problem or file system problem
>>>>>
>>>>> Note: I have formatted sd card with FAT32 file system .
>>>>>
>>>>>
>>>>>
>>>>> With EXT3 File system :
>>>>>
>>>>> Remove SD card while writing/recording we got error messages like
>>>>> below. but this is not endless. After some time it stops.
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> end_request: I/O error, dev mmcblk0, sector 156536
>>>>> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
>>>>> sending read/write command, response 0x0, card status 0x0
>>>>> mmcblk0: error -110 requesting status
>>>>> end_request: I/O error, dev mmcblk0, sector 4736
>>>>> Aborting journal on device mmcblk0p1.
>>>>> ext3_abort called.
>>>>> EXT3-fs error (device mmcblk0p1): ext3_journal_start_sb: Detected
>>>>> aborted journal
>>>>> Remounting filesystem read-only
>>>>> end_request: I/O error, dev mmcblk0, sector 4448
>>>>> journal commit I/O error
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at ?http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>> --
>>> Regards,
>>> Hardik
>>>
>>> "If you are doing what you have always been doing then expect what =
you
>>> have always been getting."
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
>
>
> --
> Regards,
> Hardik
>
> "If you are doing what you have always been doing then expect what yo=
u
> have always been getting."
>
>
>
>
>
>
>
>



--=20
Regards,
Hardik

"If you are doing what you have always been doing then expect what you
have always been getting."
