From: hardik patel <hk5patel@gmail.com>
Subject: Re: Re: Re: Re: SD Driver : FAT: FAT read failed (blocknr 8) in sd
	card error while removing sd card during writing
Date: Tue, 13 Jul 2010 14:54:33 +0530
Message-ID: <AANLkTilXlz-TZjACzY35VWK0FpPah4FXzD-BLH6RtViJ@mail.gmail.com>
References: <1434715.451771279001235044.JavaMail.weblogic@epml07>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65466 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0GMJYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2010 05:24:34 -0400
Received: by gxk23 with SMTP id 23so3029925gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jul 2010 02:24:34 -0700 (PDT)
In-Reply-To: <1434715.451771279001235044.JavaMail.weblogic@epml07>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: singh.madhav@samsung.com
Cc: Ethan Du <ethan.too@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

=46ind below diff :

--- queue.c     2010-07-13 13:52:53.000000000 +0530
+++ queue_2_6_34.c      2010-07-13 13:54:35.000000000 +0530
@@ -236,17 +236,18 @@ void mmc_cleanup_queue(struct mmc_queue
        struct request_queue *q =3D mq->queue;
        unsigned long flags;

-       /* Mark that we should start throwing out stragglers */
-       spin_lock_irqsave(q->queue_lock, flags);
-       q->queuedata =3D NULL;
-       spin_unlock_irqrestore(q->queue_lock, flags);
-
        /* Make sure the queue isn't suspended, as that will deadlock *=
/
        mmc_queue_resume(mq);

        /* Then terminate our worker thread */
        kthread_stop(mq->thread);

+       /* Empty the queue */
+        spin_lock_irqsave(q->queue_lock, flags);
+        q->queuedata =3D NULL;
+        blk_start_queue(q);
+        spin_unlock_irqrestore(q->queue_lock, flags);
+
        if (mq->bounce_sg)
                kfree(mq->bounce_sg);
        mq->bounce_sg =3D NULL;
@@ -258,8 +259,6 @@ void mmc_cleanup_queue(struct mmc_queue
                kfree(mq->bounce_buf);
        mq->bounce_buf =3D NULL;

-       blk_cleanup_queue(mq->queue);
-
        mq->card =3D NULL;
 }
 EXPORT_SYMBOL(mmc_cleanup_queue);

In card detect interrupt handler we have use tasklet.... no my Host
controller  does not support SDHCI.


On Tue, Jul 13, 2010 at 11:37 AM, MADHAV SINGHCHAUHAN
<singh.madhav@samsung.com> wrote:
>
> Hi Madhav,
>
> I have change the card remove sequence as per latest kernel source
> 2.6.34 .... after changing this i face the same issue.... is there an=
y
> way to check card detect status at block layer ? or any other way to
> avoid it ....
>>>Can i see your changes made by you..paste your diff here....Also eve=
n though you change ur card detect sequence
> still you will get these messages ,,but somewhat you can reduce these=
 messages if ur card removal sequence is efficient..
> By the way does your Host controller =A0support SDHCI??What you use i=
n card detect interrupt handler workqueue or tasklet??
> After removing card .... when i execute any command on board then als=
o
> i got below error messages :
>>>Once you remove your card =A0and if you still execute any command in=
 the mount point of the card
> you will get these type of errors ...ignore them...
>
> FAT: Directory bread(block 3898) failed
> FAT: Directory bread(block 3899) failed
> FAT: Directory bread(block 3900) failed
> FAT: Directory bread(block 3901) failed
> FAT: Directory bread(block 3902) failed
> On Mon, Jul 12, 2010 at 2:28 PM, MADHAV SINGHCHAUHAN
> <singh.madhav@samsung.com> wrote:
>>
>>
>>
>> I am using 2.6.30 linux kernel version ...
>>>>As i told you previously that you need to flush queue as soon as po=
ssible once you remove the card.
>> So once you remove card mmc_blk_remove() gets called which calls mmc=
_cleanup_queue() and it further intenally calls
>> kthread_stop()(stops thread which process requests).So compare the l=
atest kernel version wrt your kernel version
>> and you will find the differences in card remove sequence so either =
you can backport these functions or change manually
>> sequence of these functions.
>>
>> On Fri, Jul 9, 2010 at 9:20 AM, Madhav Chauhan <madhav.imsec@gmail.c=
om> wrote:
>>> On Thu, Jul 8, 2010 at 11:38 PM, hardik patel <hk5patel@gmail.com> =
wrote:
>>>> Hi Madhav,
>>>>
>>>> thanks for your interest... I have card detect register so mmc_get=
_cd
>>>> function i can check whether card is inserted or not ... so in sd =
host
>>>> controller driver can detect that properly... but i think block dr=
iver
>>>> does not detect that .... where i have to flush my request queue..=
=2E i
>>>> have gone through block.c and queue.c file which generate mmc_bloc=
k.ko
>>>> file but not sure where to modify... can any one guide me more
>>>
>>> Which Kernel version you are using??
>>>>
>>>>
>>>> On Thu, Jul 8, 2010 at 6:35 PM, MADHAV SINGHCHAUHAN
>>>> <singh.madhav@samsung.com> wrote:
>>>>> Card removal not detected by driver?
>>>>> You should see a line of log if card removal is detected:
>>>>> card xxxx removed
>>>>>
>>>>> Would you describe how do you detect card removal/insertion on yo=
ur board?
>>>>>
>>>>> Regards,
>>>>> -Ethan
>>>>>
>>>>> On Thu, Jul 8, 2010 at 6:05 PM, hardik patel <hk5patel@gmail.com>=
 wrote:
>>>>>> I have sd card on board ... During recording/writing SD card, re=
move
>>>>>> SD card ... then i am getting endless error in dmesg as below :
>>>>>>
>>>>>> end_request: I/O error, dev mmcblk0, sector 24
>>>>>> FAT: FAT read failed (blocknr 8)
>>>>>> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
>>>>>> sending read/write command, response 0x0, card status 0x0
>>>>>> Block mmc_blk_issue_rq function call 346
>>>>>> end_request: I/O error, dev mmcblk0, sector 4
>>>>>> FAT: FAT read failed (blocknr 4)
>>>>>> MMC: killing requests for dead queue
>>>>>> end_request: I/O error, dev mmcblk0, sector 8
>>>>>> FAT: FAT read failed (blocknr 8)
>>>>>> FAT: FAT read failed (blocknr 4)
>>>>>> FAT: FAT read failed (blocknr 8)
>>>>>> FAT: FAT read failed (blocknr 4)
>>>>>> FAT: FAT read failed (blocknr 8)
>>>>>> FAT: FAT read failed (blocknr 4)
>>>>>> FAT: FAT read failed (blocknr 8)
>>>>>>
>>>>>> How to stop this message ... what is ideal situation when we rem=
ove
>>>>>> card while writing ...... can u help me what to do ?
>>>>>>
>>>>>>>When we insert the card hot plug dameon start sending the reques=
t to block layer =A0and kernel block layer
>>>>>>>start sending the request to card.But when you remove the card i=
n between request queue is not flushed properly..
>>>>>>>so you need to flush your request queue at appropriate time.Also=
 please note that even that you flush your request queue
>>>>>>>at appropriate time some messages will come.
>>>>>> where is the problem here? sd host controler driver problem or b=
lock
>>>>>> driver problem or file system problem
>>>>>>
>>>>>> Note: I have formatted sd card with FAT32 file system .
>>>>>>
>>>>>>
>>>>>>
>>>>>> With EXT3 File system :
>>>>>>
>>>>>> Remove SD card while writing/recording we got error messages lik=
e
>>>>>> below. but this is not endless. After some time it stops.
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> end_request: I/O error, dev mmcblk0, sector 156536
>>>>>> mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
>>>>>> sending read/write command, response 0x0, card status 0x0
>>>>>> mmcblk0: error -110 requesting status
>>>>>> end_request: I/O error, dev mmcblk0, sector 4736
>>>>>> Aborting journal on device mmcblk0p1.
>>>>>> ext3_abort called.
>>>>>> EXT3-fs error (device mmcblk0p1): ext3_journal_start_sb: Detecte=
d
>>>>>> aborted journal
>>>>>> Remounting filesystem read-only
>>>>>> end_request: I/O error, dev mmcblk0, sector 4448
>>>>>> journal commit I/O error
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at ?http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> Regards,
>>>> Hardik
>>>>
>>>> "If you are doing what you have always been doing then expect what=
 you
>>>> have always been getting."
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>
>>
>>
>>
>> --
>> Regards,
>> Hardik
>>
>> "If you are doing what you have always been doing then expect what y=
ou
>> have always been getting."
>>
>>
>>
>>
>>
>>
>>
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
